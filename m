Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132265AbQKWATU>; Wed, 22 Nov 2000 19:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132269AbQKWATK>; Wed, 22 Nov 2000 19:19:10 -0500
Received: from chello212186054181.11.vie.surfer.at ([212.186.54.181]:12298
        "EHLO pluto.i.zmi.at") by vger.kernel.org with ESMTP
        id <S132265AbQKWASv>; Wed, 22 Nov 2000 19:18:51 -0500
Message-Id: <sa1a9dcd.091@mail.frequentis.com>
X-Mailer: KMail [version 1.1.99]
Date: Thu, 23 Nov 2000 00:48:51 +0100
From: Michael Zieger <m.zieger@zmi.at>
To: linux-kernel@vger.kernel.org
Subject: Wrong/old text in Documentation/cpqarray.txt
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-MIME-Autoconverted: from quoted-printable to 8bit by srv1.goelsen.net id QAA20716
X-UIDL: 1475160331f00972fadf96221359eb33
Organization: ZMI EDV http://www.zmi.at
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for this driver seems to be old in v2.4.0-test11-pre5:

--------------------
You need to build a new kernel to use this device, even if you want to
use a loadable module.  

Apply the patch to a 2.2.x kernel:

# cd linux
# patch -p1 <smart2.patch
---------------------

Later, there is a section:
-----------------
Booting:
--------
You'll need to use a modified lilo if you want to boot from a disk 
array.
Its simply a version of lilo with some code added to tell it how to
understand Compaq diskarray devices.
-----------------

Is this information still correct? Can't I boot from a Compaq disk 
array with a recent lilo (V 21 from SuSE 7.0)? I would need that 
feature soon and wonder where to get such a special lilo from.

Thanks in advance, and answers please per private mail, as I am not 
subscribed to this list.

mike
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
