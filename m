Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129799AbQL2CDb>; Thu, 28 Dec 2000 21:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQL2CDW>; Thu, 28 Dec 2000 21:03:22 -0500
Received: from isis.telemach.net ([213.143.65.10]:18440 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S129370AbQL2CDJ>;
	Thu, 28 Dec 2000 21:03:09 -0500
Message-ID: <3A4BE9B0.5C809AAC@telemach.net>
Date: Fri, 29 Dec 2000 02:32:32 +0100
From: Jure Pecar <pegasus@telemach.net>
Organization: Select Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: thttpd@bomb.acme.com
Subject: linux 2.2.19pre and thttpd (VM-global problem?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm expiriencing a problem with thttpd web server
(www.acme.com/software/thttpd) on recent linux 2.2 kernels with Andrea's
VM-global patches. Without the patch server runs normally with its usual
dose of complaints on the linux platform (it's being developed on BSD
afaik), but with the patch it runs ok for about three days (depends on
traffic i guess), then enters into some state where it reports 'out of
memory' for every larger file (>1Mb) it starts serving and dies. When it
comes back up it dies again whitin 10 seconds. As this is not happening
on a stock kernel and the restart of the server itself has no efect, i
conclude it has to be something there in the VM-global that thttpd
doesnt really like. As the VM-global seems to be the only cure for the
VM_do_try_to_free_pages problem, which is an issue for me too, i'd
really like to hear some official words on this before 2.2.19 comes out
with VM-global ... and while i'm at it, can we expect ide patch in
2.2.19 too?


-- 


Pegasus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
