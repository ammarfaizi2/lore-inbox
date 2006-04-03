Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWDCOK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWDCOK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWDCOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:10:29 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:46788 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751170AbWDCOK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:10:29 -0400
Date: Mon, 3 Apr 2006 16:10:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remove unused exports and save 98Kb of kernel size
Message-ID: <20060403141027.GC12873@wohnheim.fh-wedel.de>
References: <1143925545.3076.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1143925545.3076.35.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 April 2006 23:05:45 +0200, Arjan van de Ven wrote:
> 
> I've made a patch to remove all EXPORT_SYMBOL's that aren't used in the
> kernel; it's too big for the list so it can be found at
> 
> http://www.kernelmorons.org/unexport.patch
> 
> -rwxr-xr-x 1 root root 34476416 Apr  1 21:59 vmlinux.before
> -rwxr-xr-x 1 root root 34378112 Apr  1 22:48 vmlinux.after
> 
> As you can see this saves 98Kb kernel size... that's not peanuts.
> 
> Signed-off-by: Arjan van de Ven <arjan@kernelmorons.org>

Is there a reason that you always leave the newline instead of
removing it as well?  Looks script-generated, so it should be a simple
change for the script to remove the newline as well.

Jörn

-- 
If System.PrivateProfileString("",
"HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Security", "Level") <>
"" Then  CommandBars("Macro").Controls("Security...").Enabled = False
-- from the Melissa-source
