Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRABNEq>; Tue, 2 Jan 2001 08:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbRABNE0>; Tue, 2 Jan 2001 08:04:26 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:57327 "EHLO ylenurme.ee")
	by vger.kernel.org with ESMTP id <S129773AbRABNEW>;
	Tue, 2 Jan 2001 08:04:22 -0500
Date: Tue, 2 Jan 2001 14:33:29 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: <linux-kernel@vger.kernel.org>
Subject: Compile errors: RCPCI, LANE, and others
Message-ID: <Pine.LNX.4.30.0101021427070.4279-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did full compile, just for fun:

CONFIG_for Red Creek  whatever RCPCI has a syntax error
other warnings and errors, compiled on 2.4.0-prerelease, nonSMP, PIII

md5sum: WARNING: 11 of 12 computed checksums did NOT match
ec.c:279: warning: `ec_space_setup' defined but not used
{standard input}: Assembler messages:
{standard input}:765: Warning: Indirect lcall without `*'
{standard input}:849: Warning: Indirect lcall without `*'
{standard input}:936: Warning: Indirect lcall without `*'
{standard input}:976: Warning: Indirect lcall without `*'
{standard input}:1008: Warning: Indirect lcall without `*'
{standard input}:1040: Warning: Indirect lcall without `*'
{standard input}:1071: Warning: Indirect lcall without `*'
{standard input}:1100: Warning: Indirect lcall without `*'
{standard input}:1129: Warning: Indirect lcall without `*'
{standard input}:1411: Warning: Indirect lcall without `*'
{standard input}:1504: Warning: Indirect lcall without `*'
net/network.o: In function `atm_ioctl':
net/network.o(.text+0x3c742): undefined reference to `atm_lane_init'
net/network.o(.text+0x3c7f2): undefined reference to `atm_mpoa_init'
make: *** [vmlinux] Error 1
objcopy: Warning: Output file cannot represent architecture UNKNOWN!
ip2/i2cmd.c:142: warning: `ct89' defined but not used
sx.c:1623: warning: `do_memtest_w' defined but not used
i2o_block.c:595: warning: #warning "RACE"
md5sum: WARNING: 11 of 12 computed checksums did NOT match
bttv-cards.c: In function `bttv_check_chipset':
bttv-cards.c:1389: warning: unused variable `i'
bttv-cards.c: At top level:
bttv-cards.c:1379: warning: `needs_etbf' defined but not used
mtdchar.c: In function `init_mtdchar':
mtdchar.c:452: warning: unused variable `mtd'
mtdchar.c:451: warning: unused variable `name'
mtdchar.c:450: warning: unused variable `i'
ftl.c:139: warning: `debug' defined but not used
nftlmount.c: In function `check_and_mark_free_block':
nftlmount.c:363: warning: unused variable `buf'
nftlmount.c:362: warning: unused variable `i'
sunhme.c:2791: warning: #warning This needs to be corrected... -DaveM
sdla_chdlc.c: In function `if_send':
sdla_chdlc.c:936: warning: unsigned int format, long unsigned int arg (arg 3)
sdla_chdlc.c: In function `wpc_isr':
sdla_chdlc.c:1501: warning: unsigned int format, long unsigned int arg (arg 3)
sdla_ppp.c: In function `if_send':
sdla_ppp.c:901: warning: unsigned int format, long unsigned int arg (arg 3)
qla1280.c:1609: warning: `qla1280_do_dpc' defined but not used
NCR5380.c:795: warning: `NCR5380_print_options' defined but not used
sr.c: In function `sr_init_command':
sr.c:347: warning: `block' might be used uninitialized in this function
cs46xx.c:2867: warning: `amp_voyetra_4294' defined but not used
cs4281.c: In function `cs4281_write_ac97':
cs4281.c:607: warning: `status' might be used uninitialized in this function
plusb.c:985: warning: initialization from incompatible pointer type
mdacon.c:133: warning: `test_mda_b' defined but not used
matroxfb_g450.c:7: warning: `matroxfb_g450_get_reg' defined but not used
intrep.c:96: warning: `jffs_hexdump' defined but not used
dn_table.c:872: warning: `dn_fib_del_tree' defined but not used
irlap.c: In function `irlap_change_speed':
irlap.c:892: warning: implicit declaration of function `irlap_queue_xmit'
qos.c:609: warning: `byte_value' defined but not used
irias_object.c:37: warning: braces around scalar initializer
irias_object.c:37: warning: (near initialization for `missing.len')
irsyms.c:222: warning: `irda_cleanup' defined but not used
{standard input}: Assembler messages:
{standard input}:193: Warning: Indirect lcall without `*'
{standard input}:270: Warning: Indirect lcall without `*'



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
