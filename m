Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129625AbQKECyZ>; Sat, 4 Nov 2000 21:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129633AbQKECyE>; Sat, 4 Nov 2000 21:54:04 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:50954 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129625AbQKECxw>;
	Sat, 4 Nov 2000 21:53:52 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011050253.eA52rfc515962@saturn.cs.uml.edu>
Subject: Re: ext3 vs. JFS file locations...
To: dominik.kubla@uni-mainz.de (Dominik Kubla)
Date: Sat, 4 Nov 2000 21:53:41 -0500 (EST)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org,
        sct@redhat.com, sbest@us.ibm.com, linuxjfs@us.ibm.com
In-Reply-To: <20001105024621.A29327@uni-mainz.de> from "Dominik Kubla" at Nov 05, 2000 02:46:21 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla writes:
> On Fri, Nov 03, 2000 at 11:33:10AM -0800, H. Peter Anvin wrote:

[about IBM's JFS and ext3 both wanting to put code in fs/jfs]

>> How about naming it something that doesn't end in -fs, such as
>> "journal" or "jfsl" (Journaling Filesystem Layer?)
>
> Why?  I'd rather rename IBM's jfs to ibmjfs and be done with it.

jfs == Journalling File System

The journalling layer for ext3 is not a filesystem by itself.
It is generic journalling code. So, even if IBM did not have
any jfs code, the name would be wrong.

IBM ought to change their name too, because the code they ported
can not mount AIX's current filesystems. An appropriate name
would be jfs2 or os2jfs, to distinguish it from the original.
If the AIX filesystem is ever implemented for Linux, then that
code can get the jfs name.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
