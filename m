Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSHJECH>; Sat, 10 Aug 2002 00:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSHJECH>; Sat, 10 Aug 2002 00:02:07 -0400
Received: from [169.244.2.53] ([169.244.2.53]:36199 "EHLO
	netzdamon.isecuretty.com") by vger.kernel.org with ESMTP
	id <S316582AbSHJECF>; Sat, 10 Aug 2002 00:02:05 -0400
Content-Disposition: =?ISO-8859-1?Q?=82gt;Check=5Fextra=5Fheader?=
Date: Fri, 9 Aug 2002 11:09:38 -0400
From: Greg Fitzgerald <gregf@closeedge.net>
To: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, billh@gnuppy.monkey.org
Subject: Re: ext3 journal/IDE problems ?
Message-Id: <20020809110938.24de8a00.gregf@closeedge.net>
In-Reply-To: <20020809040456.GA786@gnuppy.monkey.org>
References: <20020809040456.GA786@gnuppy.monkey.org>
X-Mailer: Sylpheed version 0.8.1cvs4 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having problems with ext3 hardlocking while in X and in
Console. Symptom one is while in console moving large ammounts of data
around between partions it will hardlock. Symptom two is sometimes I
will leave my computer for a few minutes (on a very rar occasion :P )
when i return x is hardlocked. Was running XFS and Resierfs before I
tried ext3 and never had these problems. Any information I can provide
let me know.

--Greg


On Thu, 8 Aug 2002 21:04:56 -0700
Bill Huey (Hui) <billh@gnuppy.monkey.org> wrote:

> 
> Hello,
> 
> What's going on with this ?
> 
> I get:
> 
> ===========================================================
> 
> EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753210 Aborting journal on device ide0(3,5).
> Remounting filesystem read-only
> EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753211 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753212 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753213 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753214 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753215 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753216 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753217 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753218 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753219 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753220 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753221 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753222 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753223 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753224 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753225 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753226 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753227 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753228 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753229 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753230 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753231 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753232 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753233 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753234 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753235 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753236 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753237 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753238 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753239 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753240 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753241 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753242 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753243 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753244 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753245 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753246 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753247 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753248 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753249 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753250 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753251 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753252 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753253 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753254 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753255 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753256 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753257 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753258 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753259 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753260 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753261 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753262 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753263 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753264 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753265 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753266 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753267 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753268 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753269 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753270 EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already
> cleared for block 753271 EXT3-fs error (device ide0(3,5)):
> ext3_free_blocks: bit already cleared for block 753272 EXT3-fs error
> (device ide0(3,5)): ext3_free_blocks: bit already cleared for block
> 753273 ext3_free_blocks: aborting transaction: Journal has aborted in
> __ext3_journal_get_undo_access<2>EXT3-fs error (device ide0(3,5)) in
> ext3_free_blocks: Journal has aborted ext3_reserve_inode_write:
> aborting transaction: Journal has aborted in
> __ext3_journal_get_write_access<2>EXT3-fs error (device ide0(3,5)) in
> ext3_reserve_inode_write: Journal has aborted EXT3-fs error (device
> ide0(3,5)) in ext3_truncate: Journal has aborted
> ext3_reserve_inode_write: aborting transaction: Journal has aborted in
> __ext3_journal_get_write_access<2>EXT3-fs error (device ide0(3,5)) in
> ext3_reserve_inode_write: Journal has aborted EXT3-fs error (device
> ide0(3,5)) in ext3_orphan_del: Journal has aborted
> ext3_reserve_inode_write: aborting transaction: Journal has aborted in
> __ext3_journal_get_write_access<2>EXT3-fs error (device ide0(3,5)) in
> ext3_reserve_inode_write: Journal has aborted EXT3-fs error (device
> ide0(3,5)) in ext3_delete_inode: Journal has aborted
> 
> ===========================================================
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
