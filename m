Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319571AbSIMJIG>; Fri, 13 Sep 2002 05:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319574AbSIMJIG>; Fri, 13 Sep 2002 05:08:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:32401 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319571AbSIMJHJ>;
	Fri, 13 Sep 2002 05:07:09 -0400
Date: Fri, 13 Sep 2002 11:11:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Minor input fixes [6/7]
Message-ID: <20020913111130.A28494@ucw.cz>
References: <20020913110453.A28145@ucw.cz> <20020913110600.B28378@ucw.cz> <20020913110641.C28378@ucw.cz> <20020913111014.A28426@ucw.cz> <20020913111051.A28479@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020913111051.A28479@ucw.cz>; from vojtech@suse.cz on Fri, Sep 13, 2002 at 11:10:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.595, 2002-09-12 09:44:57+02:00, bhards@bigpond.net.au
  Change "D: Drivers=" to "H: Handlers=" in /proc/bus/input/devices.


 input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Thu Sep 12 23:39:03 2002
+++ b/drivers/input/input.c	Thu Sep 12 23:39:03 2002
@@ -605,7 +605,7 @@
 
 		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
 		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
-		len += sprintf(buf + len, "D: Drivers=");
+		len += sprintf(buf + len, "H: Handlers=");
 
 		list_for_each(hnode,&dev->h_list) {
 			struct input_handle * handle = to_handle(hnode);

===================================================================

This BitKeeper patch contains the following changesets:
1.595
## Wrapped with gzip_uu ##


begin 664 bkpatch25368
M'XL(`'<)@3T``\V476_;(!2&K\VO.$IO-F6Q@8"_)D_9FFF95FE1IOX`#*3V
MFIC(8%>K_./GQ%%;=5&C?5S,6$8<#O!PWE>^@&NKZ]1KS7>G98$N8&&L2SW;
M6.W+^WZ\,J8?!X79ZN"8%>2W05GM&H?Z^:5PLH!6US;UB#]]B+@?.YUZJX^?
MKJ_>KQ#*,K@L1'6COVD'68:<J5NQ478F7+$QE>]J4=FM=L*79ML]I'848]HW
M3J(IYF%'0LRB3A)%B&!$*TQ9'#)T!)L=L9^O3PC%$4GXM.,Q3PB:`_%YP@'3
M`"<!H8"3E+&41V-,4XPA+T3=H^7ES<Y4RJ^T\T4#8P(3C#[`OT6_1/)8&1C-
M4YC7Y;Z6V:@_!D:+%!:B4ILA4E80[&HC@[RQ@P"!TFTIM?71%^!QQ$*T?"PS
MFOSF@Q`6&+T[<T$U$!X!#E]?/KDLZ[LN9&'".ZKB*55J':D8$[TFIPO[THX'
MY1CCK",1B<.#CTZFG_?47W"CMA>A-JV>M=*7[7[A_4O[Q30A,0VGT9X:XX/?
M*/G%;NRLW<C_:[=!CZ\PJ>\.;V^?Y6EI_L"'\Q#'0-#GH?.\C:Y@G('=U67E
FUJ_R9@UCZ(-OGC&_?OOX2Y*%EK>VV68:"\TEY^@GM,"4CNT$````
`
end

-- 
Vojtech Pavlik
SuSE Labs
