Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUJFFgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUJFFgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUJFFgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:36:44 -0400
Received: from mta13.mail.adelphia.net ([68.168.78.44]:50108 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S267259AbUJFFgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:36:37 -0400
Message-ID: <4163845C.9020900@nodivisions.com>
Date: Wed, 06 Oct 2004 01:36:28 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: KVM -> jumping mouse... still no solution?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I first got a KVM switch around the time of kernel 2.2.something, and when 
using it to switch to a Linux system, the mouse "freaks out."  It's fine if 
you don't move it, but if you move it N/E/NE it's really slow and jerky, and 
if you move it S/W/SW even a hair, it slams down to the SW corner of the 
screen and acts like you hit all the mouse's buttons 50 times simultaneously.

When switching to an MS Windows system (any version from 98 on up; haven't 
tried anything earlier) the mouse works fine, it just pauses for maybe a 
second at first, during which I assume it's doing some kind of PS/2 reset.

It used to be that switching out of X-windows with Ctrl-Alt-F[1-6] and then 
back to VT7 would reset the mouse, but that hasn't worked in about a year 
for me.  I was also able to run a little script to send a few specific chars 
to the mouse device that seemed to reset it... that too no longer works. 
The only thing that works now is unplugging the mouse from the KVM and then 
back in.

The other day I came across this (kerneltrap.org/node/view/2199): "Use 
psmouse.proto=bare on the kernel command line, or proto=bare on the
psmouse module command line."  But that makes the mouse's scroll-wheel not 
work.  (And this problem doesn't exist with some of the mouse drivers, but 
it does with IMPS/2, which is the only one I've ever been able to get the 
scroll wheel working with.)

Is there really no solution to this problem?  If Microsoft can figure it 
out, I'm sure someone in the Linux community can... not that I'm 
volunteering, of course...

-Anthony DiSante
http://nodivisions.com/
