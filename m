Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265898AbUFISlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUFISlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUFISlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:41:53 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45189 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265898AbUFISlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:41:51 -0400
Message-ID: <40C759ED.60705@nortelnetworks.com>
Date: Wed, 09 Jun 2004 14:41:49 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Unable to totally get rid of CONFIG_INPUT options with 2.6.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a machine whose only contacts with the outside world are ethernet and 
serial.  For some reason, it appears to be impossible to disable CONFIG_INPUT. 
Is this by design?  I have everything removed from the input config screen, but 
after some digging it appears that CONFIG_INPUT is not actually controlled by 
any config files.

Is this an issue?  Would I save anything by manually editing it out?


Thanks,
Chris



#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

