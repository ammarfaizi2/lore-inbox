Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTATWZz>; Mon, 20 Jan 2003 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTATWZz>; Mon, 20 Jan 2003 17:25:55 -0500
Received: from web21512.mail.yahoo.com ([66.163.169.51]:2902 "HELO
	web21512.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267153AbTATWZy>; Mon, 20 Jan 2003 17:25:54 -0500
Message-ID: <20030120223459.57535.qmail@web21512.mail.yahoo.com>
Date: Mon, 20 Jan 2003 22:34:59 +0000 (GMT)
From: =?iso-8859-1?q?Jim=20Holliaoke?= <jholliaoke@yahoo.co.uk>
Subject: /dev/initctl
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
    When I try to boot my linux system using a rescue
disk, login as root, mount my root filesystem,
pivot_root to it and try to execute '/sbin/init', I
get an error that says 'error opening/writing control
channel /dev/initctl'. I understand that /dev/initctl
is a FIFO that used to pass messages to init and the
error message is probably caused by the absence of the
running process on the other end to pick up the
message, but isn't this the feat that an initrd
achieves with no special effort? Am I understanding
this right or is executing init from an interactive
shell prohibited?

    I have tried to find an anwser at several places
on the internet, to no avail. I'd love it if someone
could clarify this for me. 

    Please CC me as I'm not subscribed to the list.

thanks,
Jim

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
