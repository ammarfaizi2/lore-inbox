Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVDEJHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVDEJHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVDEJHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:07:34 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:28168 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261638AbVDEJH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:07:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=O0aqMOwioTlYBUk9fWv55X5LqPGxQEIoA90U4OxQLAXYaJY7HMzugRrJ/J7K9NDhQYWwDehKlxz0kOGnOr5/l4GtMLI9RqV4mApd4IaSBbct9f6Iwi/6qMbf0B1eSAB3L8/9NI9BmyYYtBQsr2av7CdB9yufeqksSPYXffXqBBY=
Message-ID: <21d7e99705040502073dfa5e5@mail.gmail.com>
Date: Tue, 5 Apr 2005 19:07:27 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: <20050405074405.GE26208@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405000524.592fc125.akpm@osdl.org>
	 <20050405074405.GE26208@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 5, 2005 5:44 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Apr 05, 2005 at 12:05:24AM -0700, Andrew Morton wrote:
> > +officially-deprecate-register_ioctl32_conversion.patch
> >
> >  deprecate a compat function (mainly affects DRI)
> 
> Those DRI callers aren't in mainline but introduced in bk-drm.patch,
> looks like the DRI folks need beating with a big stick..

Paulus these look like your patches care to update them with the "new"
method of doing stuff..

Deprecating would be no fun if the DRI didn't produce a bucket of
warnings every time..

Dave.
