Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130418AbRCEUpI>; Mon, 5 Mar 2001 15:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbRCEUo5>; Mon, 5 Mar 2001 15:44:57 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:53653 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S130418AbRCEUor>; Mon, 5 Mar 2001 15:44:47 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Mon, 5 Mar 2001 13:44:19 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_V9SQ6F32C0WDQKUT5NMR"
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: Index of Kernel Configuration Options
MIME-Version: 1.0
Message-Id: <01030513441906.01081@spc.esa.lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_V9SQ6F32C0WDQKUT5NMR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I'm not currently on the lkml list here, so I apologize if my cut and
past reply messes up someone's threaded mail reader.

AJF75 wrote:
>Does anyone know whereabouts I could go to get an index of all
>configurations options (i.e. drivers, etc.) that are available in the
>latest Linux kernel? I am waiting on a kernel mode driver for my USB
>digital camera, but I don't want to go ahead and download the full 24Mb
>just to find out if the support is available yet.

Here is a script which will print out all the kernel configuration options
found in config.in or Config.in files.  If you put this script in the
scripts directory, run it with sh scripts/options_linux (suggested name).
It should be run from the top of the tree, e.g. /usr/src/linux.

For example, to find all the USB options,
sh scripts/options_linux | grep USB

Due to tab/space munging, I'll have to attach the script.

Hope this helps. Of course, you'll still have to get the whole kernel,
which is what you were trying to avoid in the first place. ;)

Steven

--------------Boundary-00=_V9SQ6F32C0WDQKUT5NMR
Content-Type: application/x-shellscript;
  name="options_linux"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="options_linux"

IyEvYmluL3NoCiMgbW9kaWZpZWQgYnkgU3RldmVuIENvbGUgMDMvMjAwMSBmcm9tIGEgc2NyaXB0
IGJ5IFBhdWwgR29ydG1ha2VyIDAxLzIwMDEuCiMgcnVuIHRoaXMgc2NyaXB0IHdpdGggc2ggc2Ny
aXB0cy9vcHRpb25zX2xpbnV4IGZyb20gL3Vzci9zcmMvbGludXguCgpGSUxFUz1gZmluZCAuIC1u
YW1lIFtjQ11vbmZpZy5pbmAKCiMgc3BhY2UgYW5kIHRhYiBpbnNpZGUgWyAgXQpjYXQgJEZJTEVT
fGdyZXAgLXYgZGVmaW5lX3wgXApzZWQgJ3MvLipbIAldXChDT05GSUdfW0EtWmEtejAtOV9dXCtc
KVsgCV0qLiokL1wxLzt0O2QnfHNvcnR8dW5pcQo=

--------------Boundary-00=_V9SQ6F32C0WDQKUT5NMR--
