Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbTDEWw1 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTDEWw1 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:52:27 -0500
Received: from dsl254-126-114.nyc1.dsl.speakeasy.net ([216.254.126.114]:4786
	"EHLO Chumak.ny.ranok.com") by vger.kernel.org with ESMTP
	id S262704AbTDEWwA (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 17:52:00 -0500
To: linux-kernel@vger.kernel.org
Subject: [2.5.66-bk11] undefined reference to `cli' -- 600+ lines similar
MIME-Version: 1.0 (mime-construct 1.8)
Content-Transfer-Encoding: quoted-printable
Message-Id: <E191wik-0004oV-00@Maya.ny.ranok.com>
From: Vagn Scott <vagn@ranok.com>
Date: Sat, 05 Apr 2003 18:05:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

config is below
Sat Apr  5 14:59:54 EST 2003
2.5.66
patch-2.5.66-bk11.bz2
(please CC: me, as I'm not on the list)
--------------------------------

ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/mount=
s.o init/initramfs.o

ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/i386/kernel/init_task.o   init/built-in.o --start-group
usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o
--end-group  -o .tmp_vmlinux1

drivers/built-in.o(.text+0xcbaf0): In function `start_hunt':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcbaf5): In function `start_hunt':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcbb0b): In function `start_hunt':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcbb2a): In function `start_hunt':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcbb2f): In function `start_hunt':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcbc0c): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcbc11): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcbc27): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcbdbe): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcbdc3): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcbdd9): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcbdfb): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcbe00): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcbe16): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcbedd): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcbee2): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcbef5): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcbffe): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc003): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc019): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc0f7): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc0fc): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc25c): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc261): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc271): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc35e): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc363): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc379): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc474): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc479): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc48f): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc59d): In function `scc_isr_dispatch':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc5a2): In function `scc_isr_dispatch':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc5b8): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc7b2): In function `scc_isr':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc7b7): In function `scc_isr':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc7cd): In function `scc_isr':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc7ea): In function `scc_isr':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc7ef): In function `scc_isr':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc805): In function `scc_isr':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc859): In function `scc_isr':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc85e): In function `scc_isr':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc874): In function `scc_isr':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc8f3): In function `scc_isr':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc8f8): In function `scc_isr':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc90f): In function `scc_isr':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc98b): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc990): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc9a6): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc9b8): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc9bd): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcc9d0): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc9e5): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcc9ea): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcca00): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcca15): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcca1a): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcca30): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcca45): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcca4a): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcca5d): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcca72): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcca77): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcca8d): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccaa2): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccaa7): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccac2): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccaea): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccaef): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccb02): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccb17): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccb1c): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccb2f): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccba5): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccbaa): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccbc0): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccbd7): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccbdc): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccbf5): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccc0c): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccc11): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccc27): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccc4a): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccc4f): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccc65): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccc9a): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccc9f): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcccb5): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcccee): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcccf3): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccd09): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccd31): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccd36): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccd4c): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccd5d): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccd62): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccd75): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccd9e): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccda3): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccdb9): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccdf9): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccdfe): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcce14): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcce2c): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcce31): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcce4a): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcce73): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcce78): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcce8b): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccea0): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccea5): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccebb): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcced5): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcceda): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcceed): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccf06): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccf0b): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccf1e): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccf40): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccf45): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccf5b): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccf98): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccf9d): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xccfb0): In function `init_channel':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xccfbe): In function `init_channel':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xccfc3): In function `init_channel':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd098): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd09d): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd0b3): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd0cb): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd0d0): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd0e8): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd104): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd109): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd11f): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd13e): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd143): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd159): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd16e): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd173): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd18c): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd1b4): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd1b9): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd1cf): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd207): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd20c): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd222): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd243): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd248): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd25e): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd27d): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd282): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd298): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd2b0): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd2b5): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd2cd): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd2e9): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd2ee): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd304): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd323): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd328): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd33e): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd353): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd358): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd371): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd39d): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd3a2): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd3b8): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd3f3): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd3f8): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd42a): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd42f): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd461): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd466): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd47c): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd4b5): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd4ba): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd4e6): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd4eb): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd501): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd520): In function `scc_key_trx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd525): In function `scc_key_trx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd53b): In function `scc_key_trx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd578): In function `scc_start_tx_timer':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd57d): In function `scc_start_tx_timer':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd606): In function `scc_start_defer':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd60b): In function `scc_start_defer':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcd686): In function `scc_start_maxkeyup':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcd68b): In function `scc_start_maxkeyup':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcdafb): In function `t_txdelay':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcdb00): In function `t_txdelay':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcdb18): In function `t_txdelay':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcdc93): In function `t_txdelay':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcdc98): In function `t_txdelay':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcdcae): In function `t_txdelay':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcdcce): In function `t_txdelay':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcdcd3): In function `t_txdelay':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcdceb): In function `t_txdelay':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcdd83): In function `t_tail':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcdd88): In function `t_tail':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcddae): In function `t_tail':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcde7b): In function `t_busy':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcde80): In function `t_busy':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcdf63): In function `t_busy':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcdff3): In function `t_maxkeyup':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcdff8): In function `t_maxkeyup':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce00d): In function `t_maxkeyup':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce012): In function `t_maxkeyup':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce0f5): In function `t_maxkeyup':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce11c): In function `t_maxkeyup':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce121): In function `t_maxkeyup':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce137): In function `t_maxkeyup':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce156): In function `t_maxkeyup':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce15b): In function `t_maxkeyup':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce171): In function `t_maxkeyup':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce17f): In function `t_maxkeyup':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce184): In function `t_maxkeyup':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce19a): In function `t_maxkeyup':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce1a5): In function `t_maxkeyup':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce263): In function `scc_init_timer':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce268): In function `scc_init_timer':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce316): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce31b): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce331): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce351): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce356): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce36c): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce399): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce39e): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce3b4): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce3d4): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce3d9): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce3ef): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce4cc): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce4d1): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce4e9): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce4fd): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce502): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce51b): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce52f): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce534): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce54a): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce56a): In function `scc_set_param':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce56f): In function `scc_set_param':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce585): In function `scc_set_param':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce780): In function `scc_stop_calibrate':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce785): In function `scc_stop_calibrate':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce7b5): In function `scc_stop_calibrate':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce7ba): In function `scc_stop_calibrate':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce7cd): In function `scc_stop_calibrate':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce7df): In function `scc_stop_calibrate':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce7e4): In function `scc_stop_calibrate':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce7fa): In function `scc_stop_calibrate':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce890): In function `scc_start_calibrate':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce895): In function `scc_start_calibrate':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce8aa): In function `scc_start_calibrate':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce8af): In function `scc_start_calibrate':
: undefined reference to `cli'
drivers/built-in.o(.text+0xce998): In function `scc_start_calibrate':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xce9e7): In function `scc_start_calibrate':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xce9ec): In function `scc_start_calibrate':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcea02): In function `scc_start_calibrate':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcea1a): In function `scc_start_calibrate':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcea1f): In function `scc_start_calibrate':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcea37): In function `scc_start_calibrate':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xceb1b): In function `z8530_init':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xceb20): In function `z8530_init':
: undefined reference to `cli'
drivers/built-in.o(.text+0xceb33): In function `z8530_init':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xceb38): In function `z8530_init':
: undefined reference to `cli'
drivers/built-in.o(.text+0xceb51): In function `z8530_init':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xceb79): In function `z8530_init':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xceb7e): In function `z8530_init':
: undefined reference to `cli'
drivers/built-in.o(.text+0xceb94): In function `z8530_init':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xceba9): In function `z8530_init':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcebae): In function `z8530_init':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcebc7): In function `z8530_init':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcebd2): In function `z8530_init':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcee3a): In function `scc_net_close':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcee3f): In function `scc_net_close':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcee53): In function `scc_net_close':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcee58): In function `scc_net_close':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcee6b): In function `scc_net_close':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcee7d): In function `scc_net_close':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcee82): In function `scc_net_close':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcee95): In function `scc_net_close':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xceeb9): In function `scc_net_close':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xceec4): In function `scc_net_close':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xceec9): In function `scc_net_close':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcefa7): In function `scc_net_close':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcf10f): In function `scc_net_tx':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcf114): In function `scc_net_tx':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcf21f): In function `scc_net_tx':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcf3dd): In function `scc_net_ioctl':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcf3e2): In function `scc_net_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcf3f8): In function `scc_net_ioctl':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcf412): In function `scc_net_ioctl':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcf417): In function `scc_net_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcf42d): In function `scc_net_ioctl':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcf447): In function `scc_net_ioctl':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xcf44c): In function `scc_net_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0xcf45f): In function `scc_net_ioctl':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcbb4f): In function `start_hunt':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcc116): In function `scc_isr_dispatch':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd5dc): In function `scc_start_tx_timer':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd668): In function `scc_start_defer':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0xcd6e8): more undefined references to `restore_fl=
ags' follow
drivers/built-in.o(.text+0xd00a2): In function `ax_changedmtu':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0xd00a7): In function `ax_changedmtu':
: undefined reference to `cli'
drivers/built-in.o(.text+0xd014f): In function `ax_changedmtu':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1780dd): In function `lm75_attach_adapter':
: undefined reference to `i2c_detect'
drivers/built-in.o(.text+0x17855d): In function `via686a_attach_adapter':
: undefined reference to `i2c_detect'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/u1/kernel-test-bk/2.5.66/linux-2.5.66'
make: *** [recompile] Error 2
[5] Maya:/boot/kernel/test/2.5.66-bk $=20

--------------------------------
grep -v '^#' linux/.config | uniq
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

CONFIG_EXPERIMENTAL=3Dy

CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D15

CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

CONFIG_X86_PC=3Dy
CONFIG_MK7=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_SMP=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_NR_CPUS=3D32
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_EDD=3Dy
CONFIG_HIGHMEM4G=3Dy
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHPTE=3Dy
CONFIG_MTRR=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy

CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy

CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_TOSHIBA=3Dy
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy

CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy

CONFIG_X86_ACPI_CPUFREQ=3Dy
CONFIG_X86_POWERNOW_K6=3Dy
CONFIG_X86_POWERNOW_K7=3Dy

CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
CONFIG_HOTPLUG=3Dy

CONFIG_PCMCIA_PROBE=3Dy

CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dy

CONFIG_PARPORT=3Dy
CONFIG_PARPORT_PC=3Dy
CONFIG_PARPORT_PC_CML1=3Dy
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
CONFIG_PARPORT_OTHER=3Dy
CONFIG_PARPORT_1284=3Dy

CONFIG_PNP=3Dy
CONFIG_PNP_NAMES=3Dy
CONFIG_PNP_DEBUG=3Dy

CONFIG_ISAPNP=3Dy
CONFIG_PNPBIOS=3Dy

CONFIG_BLK_DEV_FD=3Dy
CONFIG_BLK_CPQ_DA=3Dy
CONFIG_BLK_CPQ_CISS_DA=3Dy
CONFIG_CISS_SCSI_TAPE=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_NBD=3Dy
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D40960
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_LBD=3Dy

CONFIG_IDE=3Dy

CONFIG_BLK_DEV_IDE=3Dy

CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_IDEDISK_STROKE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_BLK_DEV_IDESCSI=3Dy
CONFIG_IDE_TASK_IOCTL=3Dy

CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_IDE_TCQ=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=3D8
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_AMD74XX=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_BLK_DEV_PDC202XX_OLD=3Dy
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy
CONFIG_PDC202XX_FORCE=3Dy
CONFIG_BLK_DEV_VIA82CXXX=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_BLK_DEV_PDC202XX=3Dy
CONFIG_BLK_DEV_IDE_MODES=3Dy

CONFIG_SCSI=3Dy

CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dy
CONFIG_BLK_DEV_SR=3Dy
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dy

CONFIG_SCSI_REPORT_LUNS=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy

CONFIG_SCSI_GENERIC_NCR5380=3Dy
CONFIG_SCSI_GENERIC_NCR5380_MMIO=3Dy
CONFIG_SCSI_GENERIC_NCR53C400=3Dy
CONFIG_SCSI_SYM53C8XX_2=3Dy
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64

CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_LINEAR=3Dy
CONFIG_MD_RAID0=3Dy
CONFIG_MD_RAID1=3Dy
CONFIG_MD_RAID5=3Dy
CONFIG_MD_MULTIPATH=3Dy
CONFIG_BLK_DEV_DM=3Dy

CONFIG_IEEE1394=3Dy

CONFIG_IEEE1394_VERBOSEDEBUG=3Dy
CONFIG_IEEE1394_OUI_DB=3Dy

CONFIG_IEEE1394_OHCI1394=3Dy

CONFIG_IEEE1394_VIDEO1394=3Dy
CONFIG_IEEE1394_SBP2=3Dy
CONFIG_IEEE1394_SBP2_PHYS_DMA=3Dy
CONFIG_IEEE1394_ETH1394=3Dy
CONFIG_IEEE1394_DV1394=3Dy
CONFIG_IEEE1394_RAWIO=3Dy
CONFIG_IEEE1394_CMP=3Dy
CONFIG_IEEE1394_AMDTP=3Dy

CONFIG_I2O=3Dy
CONFIG_I2O_PCI=3Dy
CONFIG_I2O_BLOCK=3Dy
CONFIG_I2O_SCSI=3Dy
CONFIG_I2O_PROC=3Dy

CONFIG_NET=3Dy

CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dy

CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_COMPAT_IPCHAINS=3Dy
CONFIG_XFRM_USER=3Dy

CONFIG_IPV6_SCTP__=3Dy
CONFIG_IP_SCTP=3Dm
CONFIG_NET_HW_FLOWCONTROL=3Dy

CONFIG_NETDEVICES=3Dy

CONFIG_DUMMY=3Dy

CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_EL3=3Dy
CONFIG_VORTEX=3Dy
CONFIG_TYPHOON=3Dy
CONFIG_LANCE=3Dy

CONFIG_NET_TULIP=3Dy
CONFIG_NET_ISA=3Dy
CONFIG_EEXPRESS_PRO=3Dy
CONFIG_NET_PCI=3Dy
CONFIG_AMD8111_ETH=3Dy
CONFIG_EEPRO100=3Dy
CONFIG_8139CP=3Dy
CONFIG_8139TOO=3Dy
CONFIG_8139TOO_8129=3Dy
CONFIG_SIS900=3Dy

CONFIG_PLIP=3Dy
CONFIG_PPP=3Dy
CONFIG_PPP_ASYNC=3Dy
CONFIG_PPP_DEFLATE=3Dy
CONFIG_PPP_BSDCOMP=3Dy
CONFIG_PPPOE=3Dy
CONFIG_SLIP=3Dy
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

CONFIG_HAMRADIO=3Dy

CONFIG_AX25=3Dy
CONFIG_AX25_DAMA_SLAVE=3Dy
CONFIG_NETROM=3Dy
CONFIG_ROSE=3Dy

CONFIG_MKISS=3Dy
CONFIG_6PACK=3Dm
CONFIG_BPQETHER=3Dy
CONFIG_DMASCC=3Dm
CONFIG_SCC=3Dy
CONFIG_BAYCOM_SER_FDX=3Dm
CONFIG_BAYCOM_SER_HDX=3Dy
CONFIG_BAYCOM_PAR=3Dm
CONFIG_BAYCOM_EPP=3Dy
CONFIG_YAM=3Dm

CONFIG_IRDA=3Dy

CONFIG_IRLAN=3Dy
CONFIG_IRNET=3Dy
CONFIG_IRCOMM=3Dy
CONFIG_IRDA_ULTRA=3Dy

CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
CONFIG_IRDA_DEBUG=3Dy

CONFIG_IRTTY_SIR=3Dy

CONFIG_DONGLE=3Dy
CONFIG_ESI_DONGLE=3Dy

CONFIG_USB_IRDA=3Dm
CONFIG_NSC_FIR=3Dy
CONFIG_TOSHIBA_FIR=3Dy

CONFIG_INPUT=3Dy

CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_EVDEV=3Dy

CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy

CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_KEYBOARD_XTKBD=3Dy
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_SERIAL=3Dy

CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy

CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy

CONFIG_SERIAL_CORE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dy

CONFIG_I2C=3Dy

CONFIG_I2C_ISA=3Dy

CONFIG_SENSORS_LM75=3Dy
CONFIG_SENSORS_VIA686A=3Dy
CONFIG_I2C_SENSOR=3Dm

CONFIG_IPMI_HANDLER=3Dy
CONFIG_IPMI_PANIC_EVENT=3Dy
CONFIG_IPMI_DEVICE_INTERFACE=3Dy
CONFIG_IPMI_KCS=3Dy
CONFIG_IPMI_WATCHDOG=3Dy

CONFIG_HW_RANDOM=3Dy

CONFIG_AGP=3Dy
CONFIG_AGP3=3Dy
CONFIG_AGP_VIA=3Dy
CONFIG_AGP_I7505=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_MGA=3Dy

CONFIG_VIDEO_DEV=3Dy

CONFIG_RADIO_CADET=3Dy
CONFIG_RADIO_RTRACK=3Dy
CONFIG_RADIO_RTRACK_PORT=3D0x20f
CONFIG_RADIO_RTRACK2=3Dy
CONFIG_RADIO_RTRACK2_PORT=3D0x30c
CONFIG_RADIO_AZTECH=3Dy
CONFIG_RADIO_AZTECH_PORT=3D0x350
CONFIG_RADIO_GEMTEK=3Dy
CONFIG_RADIO_GEMTEK_PORT=3D0x34c
CONFIG_RADIO_GEMTEK_PCI=3Dy
CONFIG_RADIO_MAXIRADIO=3Dy
CONFIG_RADIO_MAESTRO=3Dy
CONFIG_RADIO_SF16FMI=3Dy
CONFIG_RADIO_TERRATEC=3Dy
CONFIG_RADIO_TERRATEC_PORT=3D0x590
CONFIG_RADIO_TRUST=3Dy
CONFIG_RADIO_TRUST_PORT=3D0x350
CONFIG_RADIO_ZOLTRIX=3Dy
CONFIG_RADIO_ZOLTRIX_PORT=3D0x20c

CONFIG_EXT2_FS=3Dy
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_JBD=3Dy
CONFIG_JBD_DEBUG=3Dy
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dy
CONFIG_REISERFS_PROC_INFO=3Dy
CONFIG_JFS_FS=3Dy
CONFIG_JFS_STATISTICS=3Dy
CONFIG_XFS_FS=3Dy
CONFIG_MINIX_FS=3Dy
CONFIG_ROMFS_FS=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTACTL=3Dy

CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dy

CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy

CONFIG_PROC_FS=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_RAMFS=3Dy

CONFIG_CRAMFS=3Dy

CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFSD=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SUNRPC_GSS=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dy
CONFIG_SMB_FS=3Dy
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
CONFIG_CIFS=3Dy
CONFIG_CODA_FS=3Dy
CONFIG_INTERMEZZO_FS=3Dy

CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_LDM_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_CODEPAGE_855=3Dy
CONFIG_NLS_CODEPAGE_865=3Dy
CONFIG_NLS_CODEPAGE_866=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dy
CONFIG_NLS_ISO8859_5=3Dy
CONFIG_NLS_ISO8859_14=3Dy
CONFIG_NLS_ISO8859_15=3Dy
CONFIG_NLS_KOI8_R=3Dy
CONFIG_NLS_KOI8_U=3Dy
CONFIG_NLS_UTF8=3Dy

CONFIG_FB=3Dy
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy

CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy

CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy

CONFIG_SOUND=3Dm

CONFIG_SND=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_VERBOSE_PRINTK=3Dy
CONFIG_SND_DEBUG=3Dy
CONFIG_SND_DEBUG_MEMORY=3Dy
CONFIG_SND_DEBUG_DETECT=3Dy

CONFIG_SND_VIRMIDI=3Dm

CONFIG_SND_EMU10K1=3Dm
CONFIG_SND_YMFPCI=3Dm
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_VIA82XX=3Dm

CONFIG_SND_USB_AUDIO=3Dm

CONFIG_USB=3Dm
CONFIG_USB_DEBUG=3Dy

CONFIG_USB_DEVICEFS=3Dy

CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_UHCI_HCD=3Dm

CONFIG_USB_AUDIO=3Dm
CONFIG_USB_MIDI=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DEBUG=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy

CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_HID_FF=3Dy
CONFIG_HID_PID=3Dy
CONFIG_LOGITECH_FF=3Dy
CONFIG_USB_HIDDEV=3Dy

CONFIG_USB_SCANNER=3Dm
CONFIG_USB_HPUSBSCSI=3Dm

CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_VISOR=3Dm

CONFIG_PROFILING=3Dy
CONFIG_OPROFILE=3Dy

CONFIG_KALLSYMS=3Dy
CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
CONFIG_FRAME_POINTER=3Dy
CONFIG_X86_EXTRA_IRQS=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy

CONFIG_SECURITY=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy

CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_MD4=3Dy
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dy
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dy
CONFIG_CRYPTO_TWOFISH=3Dy
CONFIG_CRYPTO_SERPENT=3Dy
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_TEST=3Dy

CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_X86_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_X86_TRAMPOLINE=3Dy

--=20
         _~|__
   >@   (vagn(     /
    \`-ooooooooo-'/
  ^^^^^^^^^^^^^^^^^^^^

