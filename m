Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSKFChA>; Tue, 5 Nov 2002 21:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265544AbSKFChA>; Tue, 5 Nov 2002 21:37:00 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:26357 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S265543AbSKFCgn>; Tue, 5 Nov 2002 21:36:43 -0500
Message-ID: <3DC881BF.9000807@bellatlantic.net>
Date: Tue, 05 Nov 2002 21:43:11 -0500
From: David Shepard <daveman@bellatlantic.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020518
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Shepard <daveman@bellatlantic.net>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at inode.c:1034!
References: <3DC74A26.7050401@bellatlantic.net> <20021105043628.GY23425@holomorphy.com> <3DC8187D.4090907@bellatlantic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop016.verizon.net from [151.201.13.103] at Tue, 5 Nov 2002 20:43:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm thinking this may have been more helpful after reading about ksymoops...


DEBUG (convert_uname): /lib/modules/*r/ in
DEBUG (convert_uname): /lib/modules/2.4.19/ out
ksymoops 2.4.7 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

DEBUG (main): level 1
DEBUG (read_env): default KSYMOOPS_NM=/usr/bin/nm
DEBUG (read_env): default KSYMOOPS_FIND=/usr/bin/find
DEBUG (read_env): default KSYMOOPS_OBJDUMP=/usr/bin/objdump
DEBUG (re_compile): '^([0-9a-fA-F]{4,}) +([^ ]) +([^ ]+)( +\[([^ 
]+)\])?$' 5 sub expression(s)
DEBUG (re_compile): '^ *\[*<([0-9a-fA-F]{4,})>\]* *' 1 sub expression(s)
DEBUG (re_compile): '^ *<\[([0-9a-fA-F]{4,})\]> *' 1 sub expression(s)
DEBUG (re_compile): '^ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (read_ksyms): /proc/ksyms
DEBUG (re_compile): '^([0-9a-fA-F]{4,}) +([^ ]+)( +\[([^ ]+)\])?$' 4 sub 
expression(s)
DEBUG (re_compile): '^(.*)_R.*[0-9a-fA-F]{8,}$' 1 sub expression(s)
DEBUG (re_compile): 
'^(__insmod_.*)(_O(.*)_M([0-9a-fA-F]+)_V(-?[0-9]+)|_S(.*)_L([0-9]+))' 7 
sub expression(s)
DEBUG (ss_sort_na): ppp_async
DEBUG (ss_sort_na): ppp_generic
DEBUG (ss_sort_na): slhc
DEBUG (ss_sort_na): sg
DEBUG (ss_sort_na): sd_mod
DEBUG (ss_sort_na): scsi_mod
DEBUG (ss_sort_na): parport_pc
DEBUG (ss_sort_na): lp
DEBUG (ss_sort_na): parport
DEBUG (ss_sort_na): apm
DEBUG (ss_sort_na): cs46xx
DEBUG (ss_sort_na): soundcore
DEBUG (ss_sort_na): ac97_codec
DEBUG (ss_sort_na): spca50x
DEBUG (ss_sort_na): videodev
DEBUG (ss_sort_na): uhci
DEBUG (ss_sort_na): mousedev
DEBUG (ss_sort_na): keybdev
DEBUG (ss_sort_na): evdev
DEBUG (ss_sort_na): hid
DEBUG (ss_sort_na): usbcore
DEBUG (ss_sort_na): input
DEBUG (ss_sort_na): xircom_cb
DEBUG (ss_sort_na): loop
DEBUG (ss_sort_na): msr
DEBUG (ss_sort_na): rtc
DEBUG (ss_sort_na): ksyms_base
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/net/ppp_async.o for ppp_async
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/net/ppp_generic.o for ppp_generic
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/net/slhc.o for slhc
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/scsi/sg.o for sg
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/scsi/sd_mod.o for sd_mod
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/scsi/scsi_mod.o for scsi_mod
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/parport/parport_pc.o for parport_pc
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/char/lp.o for lp
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/parport/parport.o for parport
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/arch/i386/kernel/apm.o for apm
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/sound/cs46xx.o for cs46xx
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/sound/soundcore.o for soundcore
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/sound/ac97_codec.o for ac97_codec
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/usb/spca50x.o for spca50x
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/media/video/videodev.o for videodev
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/usb/uhci.o for uhci
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/input/mousedev.o for mousedev
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/input/keybdev.o for keybdev
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/input/evdev.o for evdev
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/usb/hid.o for hid
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/usb/usbcore.o for usbcore
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/input/input.o for input
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_cb.o for xircom_cb
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/block/loop.o for loop
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/arch/i386/kernel/msr.o for msr
DEBUG (expand_objects): using 
/lib/modules/2.4.19/kernel/drivers/char/rtc.o for rtc
DEBUG (expand_objects): all ksyms modules map to specific object files
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/net/ppp_async.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/net/ppp_generic.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/net/slhc.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/scsi/sg.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/scsi/sd_mod.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/scsi/scsi_mod.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/parport/parport_pc.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/char/lp.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/parport/parport.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/arch/i386/kernel/apm.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/sound/cs46xx.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/sound/soundcore.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/sound/ac97_codec.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/usb/spca50x.o
DEBUG (ss_sort_na): 
/lib/modules/2.4.19/kernel/drivers/media/video/videodev.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/usb/uhci.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/input/mousedev.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/input/keybdev.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/input/evdev.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/usb/hid.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/usb/usbcore.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/input/input.o
DEBUG (ss_sort_na): 
/lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_cb.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/block/loop.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/arch/i386/kernel/msr.o
DEBUG (ss_sort_na): /lib/modules/2.4.19/kernel/drivers/char/rtc.o
DEBUG (read_lsmod): /proc/modules
DEBUG (re_compile): '^ *([^ ]+) *([^ ]+) *([^ ]+) *(.*)$' 4 sub 
expression(s)
DEBUG (ss_sort_na): lsmod
DEBUG (read_system_map): /usr/src/linux/System.map
DEBUG (ss_sort_na): System.map
DEBUG (merge_maps):
DEBUG (ss_sort_na): System.map
DEBUG (ss_sort_na): Version_
DEBUG (compare_Version): Version 2.4.19
DEBUG (map_ksyms_to_modules): ksyms ppp_async matches to 
/lib/modules/2.4.19/kernel/drivers/net/ppp_async.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms ppp_generic matches to 
/lib/modules/2.4.19/kernel/drivers/net/ppp_generic.o based on modutils 
assist
DEBUG (map_ksyms_to_modules): ksyms slhc matches to 
/lib/modules/2.4.19/kernel/drivers/net/slhc.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms sg matches to 
/lib/modules/2.4.19/kernel/drivers/scsi/sg.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms sd_mod matches to 
/lib/modules/2.4.19/kernel/drivers/scsi/sd_mod.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms scsi_mod matches to 
/lib/modules/2.4.19/kernel/drivers/scsi/scsi_mod.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms parport_pc matches to 
/lib/modules/2.4.19/kernel/drivers/parport/parport_pc.o based on 
modutils assist
DEBUG (map_ksyms_to_modules): ksyms lp matches to 
/lib/modules/2.4.19/kernel/drivers/char/lp.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms parport matches to 
/lib/modules/2.4.19/kernel/drivers/parport/parport.o based on modutils 
assist
DEBUG (map_ksyms_to_modules): ksyms apm matches to 
/lib/modules/2.4.19/kernel/arch/i386/kernel/apm.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms cs46xx matches to 
/lib/modules/2.4.19/kernel/drivers/sound/cs46xx.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms soundcore matches to 
/lib/modules/2.4.19/kernel/drivers/sound/soundcore.o based on modutils 
assist
DEBUG (map_ksyms_to_modules): ksyms ac97_codec matches to 
/lib/modules/2.4.19/kernel/drivers/sound/ac97_codec.o based on modutils 
assist
DEBUG (map_ksyms_to_modules): ksyms spca50x matches to 
/lib/modules/2.4.19/kernel/drivers/usb/spca50x.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms videodev matches to 
/lib/modules/2.4.19/kernel/drivers/media/video/videodev.o based on 
modutils assist
DEBUG (map_ksyms_to_modules): ksyms uhci matches to 
/lib/modules/2.4.19/kernel/drivers/usb/uhci.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms mousedev matches to 
/lib/modules/2.4.19/kernel/drivers/input/mousedev.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms keybdev matches to 
/lib/modules/2.4.19/kernel/drivers/input/keybdev.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms evdev matches to 
/lib/modules/2.4.19/kernel/drivers/input/evdev.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms hid matches to 
/lib/modules/2.4.19/kernel/drivers/usb/hid.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms usbcore matches to 
/lib/modules/2.4.19/kernel/drivers/usb/usbcore.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms input matches to 
/lib/modules/2.4.19/kernel/drivers/input/input.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms xircom_cb matches to 
/lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_cb.o based on 
modutils assist
DEBUG (map_ksyms_to_modules): ksyms loop matches to 
/lib/modules/2.4.19/kernel/drivers/block/loop.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms msr matches to 
/lib/modules/2.4.19/kernel/arch/i386/kernel/msr.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms rtc matches to 
/lib/modules/2.4.19/kernel/drivers/char/rtc.o based on modutils assist
DEBUG (ss_sort_atn): merged
DEBUG (ss_sort_atn): merged
DEBUG (ss_sort_atn): merged
DEBUG (re_compile): '^( +|[^ ]{3} [ 0-9][0-9] [0-9]{2}:[0-9]{2}:[0-9]{2} 
[^ ]+ kernel: +|<[0-9]+>|[0-9]+\|[^|]+\|[^|]+\|[^|]+\||[0-9][AC] 
[0-9]{3} [0-9]{3}[cir][0-9]{2}:)' 1 sub expression(s)
DEBUG (re_compile): '^((Stack: )|(Stack from )|([0-9a-fA-F]{4,})|(Call 
Trace: *)|(\[*<([0-9a-fA-F]{4,})>\]* *)|(Version_[0-9]+)|(Trace:)|(Call 
backtrace:)|(bh:)|<\[([0-9a-fA-F]{4,})\]> *|(\([^ ]+\) 
*\[*<([0-9a-fA-F]{4,})>\]* *)|([0-9]+ +base=)|(Kernel BackChain)|EBP 
*EIP|0x([0-9a-fA-F]{4,}) *0x([0-9a-fA-F]{4,}) *|Process 
.*stackpage=|Code *: |Kernel panic|In swapper 
task|kmem_free|swapper|Pid:|r[0-9]{1,2} *[:=]|Corrupted stack 
page|invalid operand: |Oops: |Cpu:* +[0-9]|current->tss|\*pde +=|EIP: 
|EFLAGS: |eax: |esi: |ds: |CR0: |wait_on_|irq: |Stack dumps:|RAX: |RSP: 
|RIP: |RDX: |RBP: |FS: |CS: |CR2: |PML4|pc[:=]|68060 access|Exception at 
|d[04]: |Frame format=|wb [0-9] stat|push data: |baddr=|Arithmetic 
fault|Instruction fault|Bad unaligned kernel|Forwarding unaligned 
exception|: unhandled unaligned exception|pc *=|[rvtsa][0-9]+ *=|gp 
*=|spinlock stuck|tsk->|PSR: |[goli]0: |Instruction DUMP: 
|spin_lock|TSTATE: |[goli]4: |Caller\[|CPU\[|MSR: |TASK = |last math 
|GPR[0-9]+: |\$[0-9 ]+:|epc |Status:|Cause :|Backtrace:|Function entered 
at|\*pgd =|Internal error|pc :|sp 
:|Flags:|Control:|WARNING:|this_stack:|i:|PSW|cr[0-9]+:|machine 
check|Exception in |Program Check |System restart |IUCV |unexpected 
external |Kernel stack |User process fault:|failing address|User 
PSW|User GPRS|User ACRS|Kernel PSW|Kernel GPRS|Kernel ACRS|illegal 
operation|task:|Entering kdb|eax *=|esi *=|ebp *=|ds *=|psr |unat  |rnat 
|ldrs |xip |iip |ipsr |ifa |pr |itc |ifs |bsp |[bfr][0-9]+ |irr[0-9] 
|General Exception|MCA|SAL|Processor State|Bank [0-9]+ |Register 
Stack|Processor Error Info|proc err map|proc state param|proc 
lid|processor structure|check info|target identifier|IRP *: )' 18 sub 
expression(s)
DEBUG (re_compile): 'Unable to handle kernel|Aiee|die_if_kernel|NMI |BUG 
|\(L-TLB\)|\(NOTLB\)|\([0-9]\): Oops |: memory violation|: Exception 
at|: Arithmetic fault|: Instruction fault|: arithmetic trap|: unaligned 
trap|\([0-9]+\): (Whee|Oops|Kernel|.*Penguin|BOGUS)|kernel pc |trap at 
PC: |bad area pc |NIP: | ra *==' 1 sub expression(s)
DEBUG (re_compile): '^(i[04]: |Instruction DUMP: |Caller\[)' 1 sub 
expression(s)
kernel BUG at inode.c:1034!
DEBUG (re_compile): '^PSR: [0-9a-fA-F]+ PC: ([0-9a-fA-F]{4,}) *' 1 sub 
expression(s)
DEBUG (re_compile): '^TSTATE: [0-9a-fA-F]{16} TPC: ([0-9a-fA-F]{4,}) *' 
1 sub expression(s)
DEBUG (re_compile): '(kernel pc |trap at PC: |bad area pc |NIP: 
)([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^epc *:+ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): ' ip *:+ *\[*<([0-9a-fA-F]{4,})>\]* *' 1 sub 
expression(s)
DEBUG (re_compile): '[xi]ip *\([^)]*\) *: *0x([0-9a-fA-F]{4,}) *' 1 sub 
expression(s)
DEBUG (re_compile): '(^0x([0-9a-fA-F]{4,}) *0x([0-9a-fA-F]{4,}) 
*.*+0x)|(^Entering kdb on processor.*0x([0-9a-fA-F]{4,}) *)' 5 sub 
expression(s)
DEBUG (re_compile): '^ *IRP *: *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^(EIP: +.*|RIP: +.*|PC *= *|pc *: 
*)\[*<([0-9a-fA-F]{4,})>\]* *' 2 sub expression(s)
DEBUG (re_compile): '^spinlock stuck at ([0-9a-fA-F]{4,}) *.*owner.*at 
([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^spin_lock[^ ]*\(([0-9a-fA-F]{4,}) *.*stuck at 
*([0-9a-fA-F]{4,}) *.*PC\(([0-9a-fA-F]{4,}) *' 3 sub expression(s)
DEBUG (re_compile): 'ra *=+ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^(\$[0-9]{1,2}) *: *([0-9a-fA-F]{4,}) *' 2 sub 
expression(s)
DEBUG (re_compile): '^(GPR[0-9]{1,2}) *: *([0-9a-fA-F]{4,}) *' 2 sub 
expression(s)
DEBUG (re_compile): '^PSW *flags: *([0-9a-fA-F]{4,}) * *PSW addr: 
*([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^Kernel PSW: *([0-9a-fA-F]{4,}) *([0-9a-fA-F]{4,}) 
*' 2 sub expression(s)
DEBUG (re_compile): '^((Call Trace: 
*)|(Trace:)|(\[*<([0-9a-fA-F]{4,})>\]* *)|(Call 
backtrace:)|([0-9a-fA-F]{4,}) *|Function entered at 
(\[*<([0-9a-fA-F]{4,})>\]* *)|Caller\[([0-9a-fA-F]{4,}) 
*\]|(<\[([0-9a-fA-F]{4,})\]> *)|(\([0-9]+\) *(\[*<([0-9a-fA-F]{4,})>\]* 
*))|([0-9]+ +base=0x([0-9a-fA-F]{4,}) *)|(Kernel BackChain.*))' 18 sub 
expression(s)
DEBUG (re_compile): 
'^((GP|o)?r[0-9]{1,2}|[goli][0-9]{1,2}|[eR][ABCD]X|[eR][DS]I|RBP|e[bs]p|[fsi]p|IRP|SRP|D?CCR|USP|MOF|ret_pc) 
*[:=] *([0-9a-fA-F]{4,}) * *' 3 sub expression(s)
DEBUG (re_compile): '^(Kernel GPRS.*)' 1 sub expression(s)
DEBUG (re_compile): '^(IRP|SRP|D?CCR|USP|MOF): *([0-9a-fA-F]{4,}) *' 2 
sub expression(s)
DEBUG (re_compile): '^b[0-7] *(\([^)]*\) *)?: *(0x)?([0-9a-fA-F]{4,}) *' 
3 sub expression(s)
DEBUG (re_compile): '^([^ ]+) +[^ ] *([^ ]+).*\((L-TLB|NOTLB)\)' 3 sub 
expression(s)
DEBUG (re_compile): '^((Instruction DUMP)|(Code:? *)): +((general 
protection.*)|(Bad E?IP value.*)|(<[0-9]+>)|(([<(]?[0-9a-fA-F]+[>)]? 
+)+[<(]?[0-9a-fA-F]+[>)]?))(.*)$' 10 sub expression(s)
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0156d33>]    Not tainted
DEBUG (re_compile): 'pc *: *\[*<([0-9a-fA-F]{4,})>\]* * *lr *: 
*\[*<([0-9a-fA-F]{4,})>\]* *' 2 sub expression(s)
DEBUG (re_compile): 'pc *= *\[*<([0-9a-fA-F]{4,})>\]* * *ra *= 
*\[*<([0-9a-fA-F]{4,})>\]* *' 2 sub expression(s)
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c56db150   ebx: c56db040   ecx: c56db150   edx: c56db040
esi: 00000000   edi: c7f42e00   ebp: c910a620   esp: c47f3f00
ds: 0018   es: 0018   ss:0018
Process umount (pid: 7961, stackpage=c47f3000
Stack: c11660c0 c56db040 00000296 c47f3f48 00000296 c11660c0 c56d6740 
c56d6740
Stack: c0157ea4 c11660c0 c56d6740 00000001 c7f42e60 00000001 c01573ad 
c7f42e00
Stack: c7f42ec4 c7f42e34 c910a620 c910468d c56db040 c7f42e00 c7f42e40 
c0143207
Call Trace:    [<c0157ea4>] [<c01573ad>] [<c910a620>] [<c910468d>] 
[<c0143207>]
DEBUG (re_compile): '^(\([0-9]+\) *)' 1 sub expression(s)
  [<c015ad05>] [<c015add1>] [<c015ae67>] [<c01074a3>]
Code: 0f 0b 0a 04 9d bb 27 c0 e9 48 fa ff ff 55 57 56 53 83 ec 14
DEBUG (Oops_decode):
DEBUG (re_compile): '^(([<(]?)([0-9a-fA-F]+)[)>]? *)|(Bad .*)' 4 sub 
expression(s)
DEBUG (re_compile): '^ *([0-9a-fA-F]+)( <_XXX[^>]*>)?:(.* 
+<_XXX\+0?x?([0-9a-fA-F]+)> *$)?.*' 4 sub expression(s)
DEBUG (Oops_format):


 >>EIP; c0156d33 <iput+5d3/5e0>   <=====

 >>eax; c56db150 <_end+53b03f8/8dc0308>
 >>ebx; c56db040 <_end+53b02e8/8dc0308>
 >>ecx; c56db150 <_end+53b03f8/8dc0308>
 >>edx; c56db040 <_end+53b02e8/8dc0308>
 >>edi; c7f42e00 <_end+7c180a8/8dc0308>
 >>ebp; c910a620 <[usbcore]usbdevfs_sops+0/44>
 >>esp; c47f3f00 <_end+44c91a8/8dc0308>

Trace; c0157ea4 <dispose_list+54/90>
Trace; c01573ad <invalidate_inodes+7d/90>
Trace; c910a620 <[usbcore]usbdevfs_sops+0/44>
Trace; c910468d <[usbcore]usbdevfs_put_super+4d/60>
Trace; c0143207 <kill_super+167/190>
Trace; c015ad05 <__mntput+35/60>
Trace; c015add1 <sys_umount+81/100>
Trace; c015ae67 <sys_oldumount+17/20>
Trace; c01074a3 <system_call+33/38>

Code;  c0156d33 <iput+5d3/5e0>
00000000 <_EIP>:
Code;  c0156d33 <iput+5d3/5e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0156d35 <iput+5d5/5e0>
   2:   0a 04 9d bb 27 c0 e9      or     0xe9c027bb(,%ebx,4),%al
Code;  c0156d3c <iput+5dc/5e0>
   9:   48                        dec    %eax
Code;  c0156d3d <iput+5dd/5e0>
   a:   fa                        cli
Code;  c0156d3e <iput+5de/5e0>
   b:   ff                        (bad)
Code;  c0156d3f <iput+5df/5e0>
   c:   ff 55 57                  call   *0x57(%ebp)
Code;  c0156d42 <remove_dquot_ref+2/1a0>
   f:   56                        push   %esi
Code;  c0156d43 <remove_dquot_ref+3/1a0>
  10:   53                        push   %ebx
Code;  c0156d44 <remove_dquot_ref+4/1a0>
  11:   83 ec 14                  sub    $0x14,%esp


1 warning issued.  Results may not be reliable.

