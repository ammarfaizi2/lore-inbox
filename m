Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUAVRdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUAVRdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:33:53 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:23967 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266352AbUAVRdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:33:51 -0500
Message-ID: <40100962.4040306@blue-labs.org>
Date: Thu, 22 Jan 2004 12:33:22 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Georg C. F. Greve" <greve@gnu.org>
CC: Karol Kozimor <sziwan@hell.org.pl>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
References: <m3hdyo2kce.fsf@reason.gnu-hamburg>	<20040122140155.GC5194@hell.org.pl>	<m3d69cj8hb.fsf@reason.gnu-hamburg>	<20040122154638.GA11867@hell.org.pl> <m365f3dhtv.fsf@reason.gnu-hamburg>
In-Reply-To: <m365f3dhtv.fsf@reason.gnu-hamburg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try hitting the hardware function key that swaps the CRT/LCD and/or the 
function key that changes the font.

Works on my laptop.  Really annoying two-fold issue.  First, the screen 
is blank, second, I have to blindly run setfont to change the garbage 
font to a readable font.

I'm not running an fb, just an nvidia card in text mode on a Dell 
Inspiron 8200.

David

Georg C. F. Greve wrote:

> || On Thu, 22 Jan 2004 16:46:38 +0100
> || Karol Kozimor <sziwan@hell.org.pl> wrote: 
>
> kk> Does it work before the suspend (i.e. does the backlight switch
> kk> on and off)? 
>
>Yes.
>
>
> kk> If so, your problem is probably a video driver issue and I'm
> kk> afraid I can't be of further help.
>
>Where would the people maintaining the video driver have to look?
>
>
> kk> Also, are you using a framebuffer? 
>
>Yes.
>
>
> kk> If so, try not, i.e. use a simple VGA console -> s3_bios works
> kk> fine for me on a VGA console, but produces a blank (though
> kk> backlit) screen with radeonfb.  Best regards,
>
>Interesting. I'll try that.
>
>May this be a problem of the fb driver then?
>
>Thanks for your input,
>Georg
>
>  
>
