Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752354AbWCPLG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbWCPLG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbWCPLG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:06:26 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:14437 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752335AbWCPLGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:06:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=admaBAG0JXmjBtD/+twnep81Dg2Zjphxmg7xfMhxxaxh60RrICBaImoSeHLyGkU98XY4heFt+OhF4NIawBEeVeHIZYmNudmZSA61JqkCZceMwwBkoFtev3kR08ezE8Oxa96jX6sSsdDIrdEuxfqUmGAp5bSJgodVkYJJ92oJeac=
Message-ID: <441946AA.2070006@gmail.com>
Date: Thu, 16 Mar 2006 12:06:18 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060224)
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc6-git6 compilation fails (input system)
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've a problem with gcc 4.1.0


LD drivers/ide/built-in.o
CC drivers/input/input.o
In file included from drivers/input/input.c:16:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
drivers/input/input.c: In function ‘input_register_device’:
drivers/input/input.c:842: warning: passing argument 3 of
‘handler->connect’ from incompatible pointer type
drivers/input/input.c: In function ‘input_register_handler’:
drivers/input/input.c:898: warning: passing argument 3 of
‘handler->connect’ from incompatible pointer type
CC drivers/input/mousedev.o
In file included from drivers/input/mousedev.c:21:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
drivers/input/mousedev.c:714: warning: initialization from incompatible
pointer type
CC drivers/input/evdev.o
In file included from drivers/input/evdev.c:19:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
drivers/input/evdev.c:668: warning: initialization from incompatible
pointer type
LD drivers/input/joystick/built-in.o
CC [M] drivers/input/joystick/adi.o
In file included from drivers/input/joystick/adi.c:34:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
CC drivers/input/keyboard/atkbd.o
In file included from drivers/input/keyboard/atkbd.c:26:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
LD drivers/input/keyboard/built-in.o
CC drivers/input/misc/pcspkr.o
In file included from drivers/input/misc/pcspkr.c:18:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
LD drivers/input/misc/built-in.o
CC drivers/input/mouse/psmouse-base.o
In file included from drivers/input/mouse/psmouse-base.c:19:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
CC drivers/input/mouse/alps.o
In file included from drivers/input/mouse/alps.c:17:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
CC drivers/input/mouse/logips2pp.o
In file included from drivers/input/mouse/logips2pp.c:12:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
CC drivers/input/mouse/synaptics.o
In file included from drivers/input/mouse/synaptics.c:27:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
CC drivers/input/mouse/lifebook.o
In file included from drivers/input/mouse/lifebook.c:15:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
CC drivers/input/mouse/trackpoint.o
In file included from drivers/input/mouse/trackpoint.c:15:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
LD drivers/input/mouse/psmouse.o
LD drivers/input/mouse/built-in.o
LD drivers/input/built-in.o
CC [M] drivers/input/joydev.o
In file included from include/linux/joystick.h:33,
from drivers/input/joydev.c:17:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want
In file included from drivers/input/joydev.c:18:
include/linux/input.h:1086: error: redefinition of ‘struct input_device_id’
drivers/input/joydev.c:578: warning: initialization from incompatible
pointer type
make[2]: *** [drivers/input/joydev.o] Error 1
make[1]: *** [drivers/input] Error 2
make: *** [drivers] Error 2

