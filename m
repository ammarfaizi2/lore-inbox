Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132718AbQK3KQv>; Thu, 30 Nov 2000 05:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132764AbQK3KQm>; Thu, 30 Nov 2000 05:16:42 -0500
Received: from chiara.elte.hu ([157.181.150.200]:34567 "HELO chiara.elte.hu")
        by vger.kernel.org with SMTP id <S132718AbQK3KQY>;
        Thu, 30 Nov 2000 05:16:24 -0500
Date: Thu, 30 Nov 2000 10:45:53 +0100
From: KELEMEN Peter <fuji@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: File corruption part deux
Message-ID: <20001130104553.A29224@chiara.elte.hu>
Reply-To: KELEMEN Peter <fuji@elte.hu>
In-Reply-To: <20001129163635.A406@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001129163635.A406@the-penguin.otak.com>; from lawrence@the-penguin.otak.com on Wed, Nov 29, 2000 at 04:36:35PM -0800
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
X-Beat: @448
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2000-11-29 16:36:35 -0800, Lawrence Walton wrote:

> my system has been acting slightly odd on all the pre 12 kernels
> with the fs going read only with out any messages until now.
> no opps or anything like that, but I did get this just now.

> Nov 29 16:03:12 the-penguin kernel: EXT2-fs error
> 	(device sd(8,2)): ext2_readdir:
> 	bad entry in directory #458430:
> 	directory entry across blocks - offset=152, inode=3393794200,
> 	rec_len=12440, name_len=73

> It is a SCSI only system.

I observed the same thing on EIDE (2.4.0-test11):

Nov 27 17:16:41 octavianus kernel: EXT2-fs error (device ide0(3,6)):
	ext2_readdir: bad entry in directory #60525:
	directory entry across blocks - offset=308, inode=60543,
	rec_len=34104, name_len=199

Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
