Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTDMWLn (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTDMWLn (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:11:43 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:45006 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262594AbTDMWLn (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 18:11:43 -0400
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Daniel Ritz <daniel.ritz@gmx.ch>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from illegal context
Date: Sun, 13 Apr 2003 07:02:10 +0200
User-Agent: KMail/1.5.1
References: <200304132131.03545.daniel.ritz@gmx.ch>
In-Reply-To: <200304132131.03545.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304130702.10320.d_carpenter@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 April 2003 09:31 pm, Daniel Ritz wrote:
> i saw that one after modprobe snd-sb16...
> kernel 2.5.67-bk
>
> rgds
> -daniel
>

Smatch found this bug also.
http://kbugs.org/cgi-bin/index.py?page=bug_list&script=SpinSleepLazy&skernel=2.5.67&sfile=sound

regards,
dan carpenter


