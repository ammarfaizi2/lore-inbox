Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285261AbRL2TAj>; Sat, 29 Dec 2001 14:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285250AbRL2TAb>; Sat, 29 Dec 2001 14:00:31 -0500
Received: from maila.telia.com ([194.22.194.231]:14294 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S285226AbRL2TAU>;
	Sat, 29 Dec 2001 14:00:20 -0500
Message-ID: <000901c1909b$18d530c0$0264a8c0@betty>
From: =?iso-8859-1?Q?Rickard_=C5berg?= <rickard@refused.net>
To: <linux-kernel@vger.kernel.org>
Subject: Oops msg...
Date: Sat, 29 Dec 2001 20:00:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I recieved random oops messages from the 2.4.17 kernel and I've debugged
them... but I don't quite get the output so I decided to send them here. If
someone could explain this for me I would be glad, I am not subscribed to
this list so please reply to my E-Mail address rickard@refused.net

-- cut --

DEBUG (convert_uname): /lib/modules/*r/ in
DEBUG (convert_uname): /lib/modules/2.4.17/ out
ksymoops 2.4.3 on i586 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
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
DEBUG (re_compile): '^([0-9a-fA-F]{4,}) +([^ ]) +([^ ]+)( +\[([^ ]+)\])?$' 5
sub expression(s)
DEBUG (re_compile): '^ *\[*<([0-9a-fA-F]{4,})>\]* *' 1 sub expression(s)
DEBUG (re_compile): '^ *<\[([0-9a-fA-F]{4,})\]> *' 1 sub expression(s)
DEBUG (re_compile): '^ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (read_ksyms): /proc/ksyms
DEBUG (re_compile): '^([0-9a-fA-F]{4,}) +([^ ]+)( +\[([^ ]+)\])?$' 4 sub
expression(s)
DEBUG (re_compile): '^(.*)_R.*[0-9a-fA-F]{8,}$' 1 sub expression(s)
DEBUG (re_compile):
'^(__insmod_.*)(_O(.*)_M([0-9a-fA-F]+)_V(-?[0-9]+)|_S(.*)_L([0-9]+))' 7 sub
expression(s)
DEBUG (ss_sort_na): nls_iso8859-1
DEBUG (ss_sort_na): smbfs
DEBUG (ss_sort_na): 8139too
DEBUG (ss_sort_na): ksyms_base
DEBUG (expand_objects): using
/lib/modules/2.4.17/kernel/fs/nls/nls_iso8859-1.o for nls_iso8859-1
DEBUG (expand_objects): using /lib/modules/2.4.17/kernel/fs/smbfs/smbfs.o
for smbfs
DEBUG (expand_objects): using
/lib/modules/2.4.17/kernel/drivers/net/8139too.o for 8139too
DEBUG (expand_objects): all ksyms modules map to specific object files
DEBUG (ss_sort_na): /lib/modules/2.4.17/kernel/fs/nls/nls_iso8859-1.o
DEBUG (ss_sort_na): /lib/modules/2.4.17/kernel/fs/smbfs/smbfs.o
DEBUG (ss_sort_na): /lib/modules/2.4.17/kernel/drivers/net/8139too.o
DEBUG (read_lsmod): /proc/modules
DEBUG (re_compile): '^ *([^ ]+) *([^ ]+) *([^ ]+) *(.*)$' 4 sub
expression(s)
DEBUG (ss_sort_na): lsmod
DEBUG (read_system_map): /usr/src/linux/System.map
DEBUG (ss_sort_na): System.map
DEBUG (merge_maps):
DEBUG (ss_sort_na): System.map
DEBUG (ss_sort_na): Version_
DEBUG (compare_Version): Version 2.4.16
DEBUG (map_ksyms_to_modules): ksyms nls_iso8859-1 matches to
/lib/modules/2.4.17/kernel/fs/nls/nls_iso8859-1.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms smbfs matches to
/lib/modules/2.4.17/kernel/fs/smbfs/smbfs.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms 8139too matches to
/lib/modules/2.4.17/kernel/drivers/net/8139too.o based on modutils assist
DEBUG (ss_sort_atn): merged
DEBUG (ss_sort_atn): merged
DEBUG (ss_sort_atn): merged
DEBUG (re_compile): '^( +|[^ ]{3} [ 0-9][0-9] [0-9]{2}:[0-9]{2}:[0-9]{2}
[^ ]+ kernel: +|<[0-9]+>)' 1 sub expression(s)
DEBUG (re_compile): '^((Stack: )|(Stack from )|([0-9a-fA-F]{4,})|(Call
Trace: )|(\[*<([0-9a-fA-F]{4,})>\]* *)|(Version_[0-9]+)|(Trace:)|(Call
backtrace:)|(bh:)|<\[([0-9a-fA-F]{4,})\]> *|(\([^ ]+\)
*\[*<([0-9a-fA-F]{4,})>\]* *)|([0-9]+ +base=)|(Kernel BackChain)|EBP
*EIP|0x([0-9a-fA-F]{4,}) *0x([0-9a-fA-F]{4,}) *|Process .*stackpage=|Code *:
|Kernel panic|In swapper task|kmem_free|swapper|Pid:|Corrupted stack
page|invalid operand: |Oops: |Cpu:* +[0-9]|current->tss|\*pde +=|EIP:
|EFLAGS: |eax: |esi: |ds: |CR0: |wait_on_|irq: |Stack dumps:|pc[:=]|68060
access|Exception at |d[04]: |Frame format=|wb [0-9] stat|push data:
|baddr=|Arithmetic fault|Instruction fault|Bad unaligned kernel|Forwarding
unaligned exception|: unhandled unaligned exception|pc *=|[rvtsa][0-9]+
*=|gp *=|spinlock stuck|tsk->|PSR: |[goli]0: |Instruction DUMP:
|spin_lock|TSTATE: |[goli]4: |Caller\[|CPU\[|MSR: |TASK = |last math
|GPR[0-9]+: |\$[0-9 ]+:|epc |Status:|Cause :|Backtrace:|Function entered
at|\*pgd =|Internal error|pc :|sp
:|r[0-9][0-9 ]:|Flags:|Control:|WARNING:|this_stack:|i:|PSW|cr[0-9]+:|r[0-9]
+:|machine check|Exception in |Program Check |System restart |IUCV
|unexpected external |Kernel stack |User process fault:|failing address|User
PSW|User GPRS|User ACRS|Kernel PSW|Kernel GPRS|Kernel ACRS|illegal
operation|task:|Entering kdb|eax *=|esi *=|ebp *=|ds *=|psr *:|unat *: |rnat
*: |ldrs *: |[bfr][0-9]+ *: |General Exception|IRP *: )' 18 sub
expression(s)
DEBUG (re_compile): 'Unable to handle kernel|Aiee|die_if_kernel|NMI |BUG
|\(L-TLB\)|\(NOTLB\)|\([0-9]\): Oops |: memory violation|: Exception at|:
Arithmetic fault|: Instruction fault|: arithmetic trap|: unaligned
trap|\([0-9]+\): (Whee|Oops|Kernel|.*Penguin|BOGUS)|kernel pc |trap at PC:
|bad area pc |NIP: | ra *==' 1 sub expression(s)
DEBUG (re_compile): '^(i[04]: |Instruction DUMP: |Caller\[)' 1 sub
expression(s)
Dec 29 19:16:00 louise kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000000f4
DEBUG (re_compile): '^PSR: [0-9a-fA-F]+ PC: ([0-9a-fA-F]{4,}) *' 1 sub
expression(s)
DEBUG (re_compile): '^TSTATE: [0-9a-fA-F]{16} TPC: ([0-9a-fA-F]{4,}) *' 1
sub expression(s)
DEBUG (re_compile): '(kernel pc |trap at PC: |bad area pc
|NIP: )([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^epc *:+ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): ' ip *:+ *\[*<([0-9a-fA-F]{4,})>\]* *' 1 sub
expression(s)
DEBUG (re_compile): '(^0x([0-9a-fA-F]{4,}) *0x([0-9a-fA-F]{4,})
*.*+0x)|(^Entering kdb on processor.*0x([0-9a-fA-F]{4,}) *)' 5 sub
expression(s)
DEBUG (re_compile): '^ *IRP *: *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^(EIP: +.*|PC *= *|pc *: *)\[*<([0-9a-fA-F]{4,})>\]* *'
2 sub expression(s)
DEBUG (re_compile): '^spinlock stuck at ([0-9a-fA-F]{4,}) *.*owner.*at
([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^spin_lock[^ ]*\(([0-9a-fA-F]{4,}) *.*stuck at
*([0-9a-fA-F]{4,}) *.*PC\(([0-9a-fA-F]{4,}) *' 3 sub expression(s)
DEBUG (re_compile): 'ra *=+ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^[io][04]: [0-9a-fA-F iosp:]+ ([io]7|ret_pc):
([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^PSW *flags: *([0-9a-fA-F]{4,}) * *PSW addr:
*([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^Kernel PSW: *([0-9a-fA-F]{4,}) *([0-9a-fA-F]{4,}) *' 2
sub expression(s)
DEBUG (re_compile): '^((Call Trace: )|(Trace:)|(\[*<([0-9a-fA-F]{4,})>\]*
*)|(Call backtrace:)|([0-9a-fA-F]{4,}) *|Function entered at
(\[*<([0-9a-fA-F]{4,})>\]* *)|Caller\[([0-9a-fA-F]{4,})
*\]|(<\[([0-9a-fA-F]{4,})\]> *)|(\([0-9]+\) *(\[*<([0-9a-fA-F]{4,})>\]*
*))|([0-9]+ +base=0x([0-9a-fA-F]{4,}) *)|(Kernel BackChain.*))' 18 sub
expression(s)
DEBUG (re_compile): '^(o?r[0-9]{1,2}): *([0-9a-fA-F]{4,}) *' 2 sub
expression(s)
DEBUG (re_compile): '^(Kernel GPRS.*)' 1 sub expression(s)
DEBUG (re_compile): '^(IRP|SRP|D?CCR|USP|MOF): *([0-9a-fA-F]{4,}) *' 2 sub
expression(s)
DEBUG (re_compile): '^b[0-7] *: *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^([^ ]+) +[^ ] *([^ ]+).*\((L-TLB|NOTLB)\)' 3 sub
expression(s)
DEBUG (re_compile): '^((Instruction DUMP)|(Code *)): +((general
protection.*)|(Bad E?IP value.*)|(<[0-9]+>)|(([<(]?[0-9a-fA-F]+[>)]?
+)+[<(]?[0-9a-fA-F]+[>)]?))(.*)$' 10 sub expression(s)
Dec 29 19:16:00 louise kernel: c0114965
Dec 29 19:16:00 louise kernel: *pde = 00000000
Dec 29 19:16:00 louise kernel: Oops: 0002
Dec 29 19:16:00 louise kernel: CPU:    0
Dec 29 19:16:00 louise kernel: EIP:    0010:[do_fork+1373/1600]    Not
tainted
Dec 29 19:16:00 louise kernel: EFLAGS: 00010002
Dec 29 19:16:00 louise kernel: eax: 00000040   ebx: c1ce8000   ecx: c1ce80b0
edx: 00000344
Dec 29 19:16:00 louise kernel: esi: c029c7e4   edi: c0263f84   ebp: c04a4000
esp: c04a5f7c
Dec 29 19:16:00 louise kernel: ds: 0018   es: 0018   ss: 0018
Dec 29 19:16:00 louise kernel: Process sh (pid: 1233, stackpage=c04a5000)
Dec 29 19:16:00 louise kernel: Stack: c04a4000 0809a718 bffff2cc c04a5fbc
c04a4000 00000000 000004d5 000027b3
Dec 29 19:16:01 louise kernel:        c010afc5 00000000 c04a4000 c0105848
00000011 bffff2bc c04a5fc4 00000000
Dec 29 19:16:01 louise kernel:        bffff3cc c0106bb3 bffff34c bffff34c
bffff2cc 0809a718 bffff2cc bffff3cc
Dec 29 19:16:01 louise kernel: Call Trace: [sys_pipe+21/88] [sys_fork+20/28]
[system_call+51/64]
DEBUG (re_compile): '^(\([0-9]+\) *)' 1 sub expression(s)
Dec 29 19:16:01 louise kernel: Code: 89 88 b4 00 00 00 89 9a a0 c4 29 c0 89
b3 b4 00 00 00 ff 05
Using defaults from ksymoops -t elf32-i386 -a i386
DEBUG (Oops_decode):
DEBUG (re_compile): '^(([<(]?)([0-9a-fA-F]+)[)>]? *)|(Bad .*)' 4 sub
expression(s)
DEBUG (re_compile): '^ *([0-9a-fA-F]+)( <_XXX[^>]*>)?:(.*
+<_XXX\+0?x?([0-9a-fA-F]+)> *$)?.*' 4 sub expression(s)
DEBUG (Oops_format):

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 88 b4 00 00 00         mov    %ecx,0xb4(%eax)
Code;  00000006 Before first symbol
   6:   89 9a a0 c4 29 c0         mov    %ebx,0xc029c4a0(%edx)
Code;  0000000c Before first symbol
   c:   89 b3 b4 00 00 00         mov    %esi,0xb4(%ebx)
Code;  00000012 Before first symbol
  12:   ff 05 00 00 00 00         incl   0x0

Dec 29 19:19:08 louise kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 000000bc
Dec 29 19:19:08 louise kernel: c014bd05
Dec 29 19:19:08 louise kernel: *pde = 00000000
Dec 29 19:19:08 louise kernel: Oops: 0000
Dec 29 19:19:08 louise kernel: CPU:    0
Dec 29 19:19:08 louise kernel: EIP:    0010:[proc_pid_lookup+305/476]    Not
tainted
Dec 29 19:19:08 louise kernel: EFLAGS: 00010202
Dec 29 19:19:08 louise kernel: eax: 000000d1   ebx: 000004d5   ecx: 00000003
edx: 00000007
Dec 29 19:19:08 louise kernel: esi: c156cfa0   edi: 00000040   ebp: c156cf40
esp: c24dfef8
Dec 29 19:19:08 louise kernel: ds: 0018   es: 0018   ss: 0018
Dec 29 19:19:08 louise kernel: Process ps (pid: 1248, stackpage=c24df000)
Dec 29 19:19:08 louise kernel: Stack: c3d65400 c156cf40 c3d65400 c3d65468
c156cfa0 ffffffff c014aada c3d65400
Dec 29 19:19:08 louise kernel:        c156cf40 fffffff4 c156cf40 c01379bb
c3d65400 c156cf40 00c1c9a8 00000000
Dec 29 19:19:08 louise kernel:        c24dffa4 c24dff74 c0137fd0 c3d641a0
c24dff74 00000000 c1dc3000 00000000
Dec 29 19:19:08 louise kernel: Call Trace: [proc_root_lookup+58/72]
[real_lookup+83/196] [link_path_walk+1224/1784] [path_walk+26/28]
[__user_walk+53/80]
Dec 29 19:19:08 louise kernel: Code: 39 5f 7c 74 0a 8b bf b0 00 00 00 85 ff
75 f1 85 ff 0f 84 88
DEBUG (Oops_decode):
DEBUG (Oops_format):

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 5f 7c                  cmp    %ebx,0x7c(%edi)
Code;  00000002 Before first symbol
   3:   74 0a                     je     f <_EIP+0xf> 0000000e Before first
symbol
Code;  00000004 Before first symbol
   5:   8b bf b0 00 00 00         mov    0xb0(%edi),%edi
Code;  0000000a Before first symbol
   b:   85 ff                     test   %edi,%edi
Code;  0000000c Before first symbol
   d:   75 f1                     jne    0 <_EIP>
Code;  0000000e Before first symbol
   f:   85 ff                     test   %edi,%edi
Code;  00000010 Before first symbol
  11:   0f 84 88 00 00 00         je     9f <_EIP+0x9f> 0000009e Before
first symbol

Dec 29 19:19:44 louise kernel:  <1>Unable to handle kernel paging request at
virtual address 459ecba4
Dec 29 19:19:44 louise kernel: c01387e8
Dec 29 19:19:44 louise kernel: *pde = 00000000
Dec 29 19:19:44 louise kernel: Oops: 0000
Dec 29 19:19:44 louise kernel: CPU:    0
Dec 29 19:19:44 louise kernel: EIP:    0010:[open_namei+380/1504]    Not
tainted
Dec 29 19:19:44 louise kernel: EFLAGS: 00010246
Dec 29 19:19:44 louise kernel: eax: c17e32a0   ebx: c27aa760   ecx: c17d76a8
edx: 00000000
Dec 29 19:19:44 louise kernel: esi: c17e32a0   edi: c1613f8c   ebp: 00000242
esp: c1613f48
Dec 29 19:19:44 louise kernel: ds: 0018   es: 0018   ss: 0018
Dec 29 19:19:44 louise kernel: Process nmbd (pid: 502, stackpage=c1613000)
Dec 29 19:19:44 louise kernel: Stack: 00000000 c17e32a0 00000241 c1cff000
08099be2 bffff418 00000000 c1613f94
Dec 29 19:19:44 louise kernel:        00000000 00000002 c27aa760 c012f0fc
c1cff000 00000242 000001a4 c1613f8c
Dec 29 19:19:44 louise kernel:        00000011 c17e32a0 c10fd320 c1cff011
0000000b f5840658 00000010 00000000
Dec 29 19:19:44 louise kernel: Call Trace: [filp_open+48/80]
[sys_open+54/148] [system_call+51/64]
Dec 29 19:19:44 louise kernel: Code: 00 8b 44 24 24 83 c4 04 89 07 83 7c 24
10 00 0f 85 50 03 00
DEBUG (Oops_decode):
DEBUG (Oops_format):

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   00 8b 44 24 24 83         add    %cl,0x83242444(%ebx)
Code;  00000006 Before first symbol
   6:   c4 04 89                  les    (%ecx,%ecx,4),%eax
Code;  00000008 Before first symbol
   9:   07                        pop    %es
Code;  0000000a Before first symbol
   a:   83 7c 24 10 00            cmpl   $0x0,0x10(%esp,1)
Code;  0000000e Before first symbol
   f:   0f 85 50 03 00 00         jne    365 <_EIP+0x365> 00000364 Before
first symbol


1 warning issued.  Results may not be reliable.


-- cut ---

Thanks,
Rickard

