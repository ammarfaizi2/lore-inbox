Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272752AbTHKQm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272799AbTHKQl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:41:56 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51974 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S272752AbTHKQjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:39:43 -0400
Date: Mon, 11 Aug 2003 18:39:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Gregory G Carter <gcarter@aesgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 Test3 Config Compile Failure
Message-ID: <20030811163927.GA1789@mars.ravnborg.org>
Mail-Followup-To: Gregory G Carter <gcarter@aesgi.com>,
	linux-kernel@vger.kernel.org
References: <3F37BD21.4030701@aesgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37BD21.4030701@aesgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 10:58:25AM -0500, Gregory G Carter wrote:
> The configuration program included with 2.6.0, allows a end-user to 
> configure the kernel in such a way as to prevent it from compiling.
> 
> Please fix.

Would be nice, but almost impossible.
The problem you see are in device drivers, and device drivers
does not get fixed unless someone actually cares and fix the driver in
question.
During the 2.5 cycle several internal interfaces were changed
resulting in a wast amount of drivers that no longer compile.

The usual reply to postings like yours is "Patches welcome" ;-)

	Sam
