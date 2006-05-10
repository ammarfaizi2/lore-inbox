Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWEJVKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWEJVKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEJVKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:10:54 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:43929
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964856AbWEJVKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:10:54 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 2/6] New Generic HW RNG
Date: Wed, 10 May 2006 23:18:16 +0200
User-Agent: KMail/1.9.1
References: <20060507113513.418451000@pc1> <200605071516.09167.mb@bu3sch.de> <20060510205743.GC23446@suse.de>
In-Reply-To: <20060510205743.GC23446@suse.de>
Cc: Sergey Vlasov <vsu@altlinux.ru>, akpm@osdl.org,
       Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605102318.16939.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 22:57, you wrote:
> On Sun, May 07, 2006 at 03:16:08PM +0200, Michael Buesch wrote:
> > On Sunday 07 May 2006 15:03, you wrote:
> > > > +	list_for_each_entry(rng, &rng_list, list) {
> > > > +		if (strncmp(rng->name, buf, len) == 0) {
> > > 
> > > This will match if the passed string is just a prefix of rng->name.
> > > Apparently sysfs guarantees that the buffer passed to ->store will be
> > > NUL-terminated, so this should be just a strcmp().
> > 
> > I am not sure if it is guaranteed NUL terminated. Greg?
> > But I will look into this.
> 
> Yes it will be.

Ok, very nice.
I will resend the patches as soon as I have some time.
I also splitted up the x86 drivers. Looks very good and clean now. ;)

-- 
Greetings Michael.
