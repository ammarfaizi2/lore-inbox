Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUAABL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 20:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUAABL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 20:11:29 -0500
Received: from simmts8.bellnexxia.net ([206.47.199.166]:29650 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265301AbUAABL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 20:11:28 -0500
Message-ID: <3FF373EC.3000207@sympatico.ca>
Date: Thu, 01 Jan 2004 01:12:12 +0000
From: Tyler Hall <tyler_hall@sympatico.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: device classes in sysfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has there ever been any discussion about classifying devices according 
to their function, and providing an interface (say with libsysfs) for 
user apps to enumerate a particular class? The new udev project _does_ 
provide the nice feature of persistent naming of a given device that can 
change positions on a bus (like 2 USB printers that change USB ports), 
but what about hunting for devices that provide the same function that 
can exist on any bus (like 1 parallel port printer and 1 USB printer)?

_After_ devices are configured and assigned names, users can depend on 
udev and friends to provide the same name to their devices. But _before_ 
the devices are initially configured, users (rather, writers of user 
apps) have to pull some special hacks to scan buses or dig deep into 
/proc to find what devices provide some target function (like printing).

I see /sys/class, but that seems more defined as "hardware architecture" 
class rather than "function" class.

Any opinions?

Tyler

