Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTIDLlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTIDLlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:41:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17168 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264923AbTIDLll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:41:41 -0400
Date: Thu, 4 Sep 2003 12:41:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call of tty->driver.write provides segmentation fault
Message-ID: <20030904124138.B8414@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>,
	linux-kernel@vger.kernel.org
References: <200309041107.12393.laurent.huge@wanadoo.fr> <20030904105257.B7387@flint.arm.linux.org.uk> <200309041335.14730.laurent.huge@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309041335.14730.laurent.huge@wanadoo.fr>; from laurent.huge@wanadoo.fr on Thu, Sep 04, 2003 at 01:35:14PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:35:14PM +0200, Laurent Hugé wrote:
> Le Jeudi 4 Septembre 2003 11:52, Russell King a écrit :
> > You need to look at the kernel messages - normally you'll find an
> > "oops" in there when this happens.
> There's no Oops ; I've only got a segmentation fault, but the kernel doesn't 
> crash.

If that's the case, I can't help you.  If the kernel isn't oopsing, then
it isn't the call to tty->driver.write which is causing your problem -
it must be an error in the userspace program.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

