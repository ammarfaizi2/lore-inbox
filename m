Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTJHVfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTJHVfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:35:15 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:18187 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261796AbTJHVfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:35:12 -0400
Date: Wed, 8 Oct 2003 23:35:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Steudten <alpha@steudten.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: linux-2.6.0-test6: make -O=/var/tmp/build help
Message-ID: <20031008213505.GA1045@mars.ravnborg.org>
Mail-Followup-To: Thomas Steudten <alpha@steudten.com>,
	linux-kernel@vger.kernel.org
References: <3F846637.5040509@steudten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F846637.5040509@steudten.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 09:32:07PM +0200, Thomas Steudten wrote:
> Hello
> 
> Maybe i´m not up-to-date, but i tried out the new 2.6 kernel
> with the new -O option and it fails with:
> Without the -O option it works. Normally one calls
> make help and not make -O.. help, but this fails also,
> if the environment variable for -O is set.

Thanks, already fixed in my local tree.
[Append $(srctree)/ to path to makefiles.

	Sam
