Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUJ3AGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUJ3AGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263707AbUJ3AFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:05:45 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:7441 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S263676AbUJ3ADU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:03:20 -0400
Date: Fri, 29 Oct 2004 17:02:34 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5
Message-ID: <20041030000234.GA20986@nietzsche.lynx.com>
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu> <417FD9F2.8060002@stud.feec.vutbr.cz> <20041028115719.GA9563@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20041028115719.GA9563@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 28, 2004 at 01:57:19PM +0200, Ingo Molnar wrote: > 
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> 
> > > i've uploaded -V0.4.1 with a fix that could fix this networking
> > > deadlock. Does it work any better?
> > 
> > Unfortunately, no. It's only slightly different:
> 
> ok. I've uploaded -RT-V0.5 which includes a different approach to
> solving these netfilter related deadlocks. It can be downloaded from the 
> usual place:

This is in -V5.14

bill



--3lcZGd9BuhuYXNfi
Content-Type: application/x-troff
Content-Disposition: attachment; filename=t
Content-Transfer-Encoding: quoted-printable

/usr/bin/distccd not starting=0AStarting file alteration monitor: FAM.=0ASt=
arting mouse interface server: gpm.=0AStarting internet superserver: inetd.=
=0ANot starting NFS kernel daemon: No exports.=0AStarting network top daemo=
n:=0Adevice eth0 entered promiscuous mode=0Arsync daemon not enabled in /et=
c/default/rsync=0AStarting OpenBSD Secure Shell server: sshd.=0ASyncing UMS=
DOS filesystems ...=0ASetting up X font server socket directory /tmp/.font-=
unix...done.=0AStarting X font server: xfs.=0AStarting Xprint servers: Xprt=
=2E=0A/etc/rc2.d/S20xprint: ## WARNING: Can't find "/usr/X11R6/lib/X11/font=
s/encodings/encodings.dir", TrueType fon.=0AStarting NFS common utilities: =
statd.=0AStarting NTP server: ntpd.=0AStarting deferred execution scheduler=
: atd.=0AStarting periodic command scheduler: cron.=0A=0ADebian GNU/Linux 3=
=2E1 aesthetics ttyS1=0A=0Aaesthetics login: billh=0APassword: =0ALast logi=
n: Fri Oct 29 14:18:11 2004 on ttyS1=0ALinux aesthetics 2.6.9-mm1-RT-V0.5.1=
4 #1 SMP Fri Oct 29 16:39:52 PDT 2004 i686 GNU/Linux=0A=0AThe programs incl=
uded with the Debian GNU/Linux system are free software;=0Athe exact distri=
bution terms for each program are described in the=0Aindividual files in /u=
sr/share/doc/*/copyright.=0A=0ADebian GNU/Linux comes with ABSOLUTELY NO WA=
RRANTY, to the extent=0Apermitted by applicable law.=0AYou have mail.=0ACou=
ldnt get a file descriptor referring to the console=0Abillh@aesthetics> /ho=
me/billh% 1% su=0APassword: =0Aroot@aesthetics> /home/billh% 1# apt-get upd=
ate=0AErr http://marillat.free.fr unstable/main Packages=0A  503 Service Un=
available=0AIgn http://marillat.free.fr unstable/main Release=0AHit http://=
gmonsters.sourceforge.net ./ Packages=0AIgn http://gmonsters.sourceforge.ne=
t ./ Release=0AGet:1 http://pkg-gnome.alioth.debia                         =
                    =0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0ABUG: circular semaphore deadlock detected!=0A------------=
-----------------------------------=0Aksoftirqd/0/3 is deadlocking current =
task http/554=0A=0A=0A1) http/554 is trying to acquire this lock:=0A [c041f=
560] {r:0,a:-1,net/core/dev.c:157}=0A.. held by:       ksoftirqd/0/    3 [c=
1794cc0]=0A... acquired at:  netif_receive_skb+0x80/0x200=0A... at: dev_que=
ue_xmit_nit+0x41/0x130=0A=0A2) ksoftirqd/0/3 is blocked on this lock:=0A [d=
fee9194] {r:0,a:-1,&dev->xmit_lock}=0A.. held by:              http/  554 [=
dcff3320]=0A... acquired at:  qdisc_restart+0x262/0x280=0A=0A--------------=
----------------=0A| showing all locks held by: |  (http/554 [dcff3320]):=
=0A------------------------------=0A=0A#001:             [dfee9194] {r:0,a:=
-1,&dev->xmit_lock}=0A... acquired at:  qdisc_restart+0x262/0x280=0A=0A----=
--------------------------=0A| showing all locks held by: |  (ksoftirqd/0/3=
 [c1794cc0]):=0A------------------------------=0A=0A#001:             [c041=
f560] {r:0,a:-1,net/core/dev.c:157}=0A... acquired at:  netif_receive_skb+0=
x80/0x200=0A=0A#002:             [c045c780] {r:0,a:-1,inet_proto_lock}=0A..=
=2E acquired at:  ip_local_deliver+0x9e/0x2f0=0A=0A#003:             [dbf60=
ec0] {r:0,a:-1,&((sk)->sk_lock.slock)}=0A... acquired at:  tcp_v4_rcv+0x631=
/0xa50=0A=0Aksoftirqd/0/3's [blocked] stackdump:=0A=0Ac179db28 00000046 c17=
94cc0 c140b820 c179dad8 00000001 c179c000 dfee9194 =0A       c1794cc0 dfee9=
198 00000202 c0138d7d c020e8b4 00000000 dff6b000 00000000 =0A       c1794cc=
0 dfee9198 dcff3320 c140b820 000003bb 6039ceaa 00000022 c1794e8c =0ACall Tr=
ace:=0A [<c03923e0>] schedule+0x40/0x140 (36)=0A [<c03938ad>] down_write_mu=
tex+0x1bd/0x260 (68)=0A [<c01386b4>] __mutex_lock+0x44/0x60 (24)=0A [<c0138=
6ed>] _mutex_lock+0x1d/0x30 (16)=0A [<c0328d52>] qdisc_restart+0x262/0x280 =
(56)=0A [<c031be7f>] dev_queue_xmit+0x1ff/0x2b0 (32)=0A [<c0322608>] neigh_=
resolve_output+0xf8/0x230 (56)=0A [<c03348e9>] ip_finish_output+0xd9/0x280 =
(56)=0A [<c03351bd>] ip_queue_xmit+0x47d/0x5f0 (228)=0A [<c03473b2>] tcp_tr=
ansmit_skb+0x522/0x8e0 (84)=0A [<c034a1e9>] tcp_send_ack+0xa9/0xf0 (36)=0A =
[<c03458c4>] tcp_rcv_established+0x734/0x980 (52)=0A [<c034efba>] tcp_v4_do=
_rcv+0x15a/0x160 (32)=0A [<c034f7af>] tcp_v4_rcv+0x7ef/0xa50 (80)=0A [<c033=
0fd5>] ip_local_deliver+0x115/0x2f0 (48)=0A [<c033144c>] ip_rcv+0x29c/0x550=
 (56)=0A [<c031c435>] netif_receive_skb+0x135/0x200 (40)=0A [<c031c5a0>] pr=
ocess_backlog+0xa0/0x1c0 (48)=0A [<c031c762>] net_rx_action+0xa2/0x1d0 (44)=
=0A [<c0126b72>] ___do_softirq+0xc2/0x120 (48)=0A [<c0126c95>] _do_softirq+=
0x25/0x30 (8)=0A [<c0127226>] ksoftirqd+0xc6/0x100 (24)=0A [<c0137b7b>] kth=
read+0xbb/0xc0 (48)=0A [<c0104559>] kernel_thread_helper+0x5/0xc (104897742=
8)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-level =
deep critical section nesting:=0A----------------------------------------=
=0A.. [<c0391b9f>] .... __schedule+0x4f/0x850=0A.....[<c03923e0>] ..   ( <=
=3D schedule+0x40/0x140)=0A.. [<c0393e82>] .... _spin_lock_irqsave+0x22/0x8=
0=0A.....[<c0391c3e>] ..   ( <=3D __schedule+0xee/0x850)=0A=0A=0Ahttp/554's=
 [current] stackdump:=0A=0A[<c020ea73>] check_deadlock+0x1d3/0x270=0A[<c020=
eb36>] task_blocks_on_sem+0x26/0x40=0A[<c039387a>] down_write_mutex+0x18a/0=
x260=0A[<c031b871>] dev_queue_xmit_nit+0x41/0x130=0A[<c0328d3f>] qdisc_rest=
art+0x24f/0x280=0A[<c031be7f>] dev_queue_xmit+0x1ff/0x2b0=0A[<c03348e9>] ip=
_finish_output+0xd9/0x280=0A[<c03351bd>] ip_queue_xmit+0x47d/0x5f0=0A[<c034=
73b2>] tcp_transmit_skb+0x522/0x8e0=0A[<c0347886>] tcp_push_one+0xa6/0x170=
=0A[<c033b098>] tcp_sendmsg+0x768/0x11f0=0A[<c035fa00>] inet_sendmsg+0x50/0=
x60=0A[<c0311716>] sock_aio_write+0xf6/0x120=0A[<c01623d8>] do_sync_write+0=
xa8/0xe0=0A[<c0162525>] vfs_write+0x115/0x150=0A[<c010665b>] syscall_call+0=
x7/0xb=0A=0Ashowing all tasks:=0As            init/    1 [c1795980] (not bl=
ocked)=0As     migration/0/    2 [c1795320] (not blocked)=0AD     ksoftirqd=
/0/    3 [c1794cc0] blocked on: [dfee9194] {r:0,a:-1,&dev->xmit_lock}=0A.. =
held by:              http/  554 [dcff3320]=0A... acquired at:  qdisc_resta=
rt+0x262/0x280=0As       desched/0/    4 [c1794660] (not blocked)=0As      =
  events/0/    5 [c1794000] (not blocked)=0As         khelper/    6 [c17b39=
80] (not blocked)=0As         kthread/    7 [c17b3320] (not blocked)=0As   =
    kblockd/0/    8 [c17b2cc0] (not blocked)=0As           khubd/    9 [c17=
b2660] (not blocked)=0As         pdflush/   10 [c17b2000] (not blocked)=0As=
         pdflush/   11 [dfdf1980] (not blocked)=0As           aio/0/   13 [=
dfdf0cc0] (not blocked)=0As         kswapd0/   12 [dfdf1320] (not blocked)=
=0As           IRQ 8/   14 [dfdf0660] (not blocked)=0As          IRQ 12/   =
16 [dfec7980] (not blocked)=0As           IRQ 6/   17 [dfec7320] (not block=
ed)=0As         kseriod/   15 [dfdf0000] (not blocked)=0As          IRQ 14/=
   18 [dfec6cc0] (not blocked)=0As          IRQ 15/   19 [dfec6660] (not bl=
ocked)=0As          IRQ 16/   20 [dfec6000] (not blocked)=0As       scsi_eh=
_0/   21 [dff13980] (not blocked)=0As        ahc_dv_0/   22 [dff13320] (not=
 blocked)=0As           IRQ 1/   23 [dff12000] (not blocked)=0As       kjou=
rnald/   24 [dff12660] (not blocked)=0As           IRQ 3/   25 [dff12cc0] (=
not blocked)=0As           IRQ 4/  154 [df577320] (not blocked)=0As        =
  IRQ 18/  239 [dfac4660] (not blocked)=0As         portmap/  244 [dfac4cc0=
] (not blocked)=0As        rpciod/0/  250 [df576660] (not blocked)=0As     =
      lockd/  251 [df576000] (not blocked)=0As         syslogd/  306 [df577=
980] (not blocked)=0As           klogd/  309 [df576cc0] (not blocked)=0As  =
          famd/  326 [dfac4000] (not blocked)=0As             gpm/  330 [df=
6e1980] (not blocked)=0As           inetd/  335 [dfac5320] (not blocked)=0A=
s            ntop/  342 [df6e0cc0] (not blocked)=0As            ntop/  455 =
[dcc2a660] (not blocked)=0As            ntop/  456 [dcc2acc0] (not blocked)=
=0As            ntop/  457 [dcc2b320] (not blocked)=0As            ntop/  4=
58 [dcf0f320] (not blocked)=0As            ntop/  486 [dd5dccc0] (not block=
ed)=0As            ntop/  493 [df6e0660] (not blocked)=0As            ntop/=
  494 [dcf0e000] (not blocked)=0As            sshd/  351 [df6e1320] (not bl=
ocked)=0As             xfs/  361 [dd5dd320] (not blocked)=0As       rpc.sta=
td/  444 [dcf0ecc0] (not blocked)=0As            ntpd/  459 [df6e0000] (not=
 blocked)=0As             atd/  466 [dcc2b980] (not blocked)=0As           =
 cron/  479 [dcff2000] (not blocked)=0As           getty/  495 [dfac5980] (=
not blocked)=0As           getty/  496 [dcf0e660] (not blocked)=0As        =
   getty/  497 [dcf0f980] (not blocked)=0As           getty/  498 [dcff3980=
] (not blocked)=0As           getty/  499 [dcff2660] (not blocked)=0As     =
      getty/  500 [dcff2cc0] (not blocked)=0As           getty/  501 [dd5dc=
000] (not blocked)=0As            tcsh/  504 [dc78b320] (not blocked)=0As  =
           csh/  548 [dd5dd980] (not blocked)=0As         apt-get/  551 [dd=
5dc660] (not blocked)=0As            http/  553 [dcc2a000] (not blocked)=0A=
R            http/  554 [dcff3320] (not blocked)=0As            http/  555 =
[dc78a000] (not blocked)=0As            http/  556 [dc78a660] (not blocked)=
=0As            http/  557 [dc78acc0] (not blocked)=0As            http/  5=
58 [dc78b980] (not blocked)=0As            http/  559 [dc3fd980] (not block=
ed)=0As            http/  560 [dc3fd320] (not blocked)=0As            http/=
  561 [dc3fccc0] (not blocked)=0As            http/  562 [dc3fc660] (not bl=
ocked)=0As            http/  563 [dc3fc000] (not blocked)=0As            ht=
tp/  564 [dbcd5980] (not blocked)=0As            http/  565 [dbcd5320] (not=
 blocked)=0As            http/  566 [dbcd4cc0] (not blocked)=0As           =
 http/  567 [dbcd4660] (not blocked)=0As            http/  568 [dbcd4000] (=
not blocked)=0As            http/  569 [dbdab980] (not blocked)=0As        =
    http/  570 [dbdab320] (not blocked)=0As            http/  571 [dbdaacc0=
] (not blocked)=0As            http/  572 [dbdaa660] (not blocked)=0As     =
       http/  573 [dbdaa000] (not blocked)=0As            http/  574 [dbe83=
980] (not blocked)=0As            gzip/  576 [dbe83320] (not blocked)=0AR  =
          gzip/  577 [dbe82cc0] (not blocked)=0A=0A------------------------=
---=0A| showing all locks held: |=0A---------------------------=0A=0A#001: =
            [c054e82c] {r:0,a:-1,&hwif->gendev_rel_sem}=0A.. held by:      =
        init/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x94/0x180=
=0A=0A#002:             [c054e434] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. h=
eld by:              init/    1 [c1795980]=0A... acquired at:  init_hwif_da=
ta+0x160/0x180=0A=0A#003:             [c054e614] {r:0,a:-1,&drive->gendev_r=
el_sem}=0A.. held by:              init/    1 [c1795980]=0A... acquired at:=
  init_hwif_data+0x160/0x180=0A=0A#004:             [c054eeb8] {r:0,a:-1,&h=
wif->gendev_rel_sem}=0A.. held by:              init/    1 [c1795980]=0A...=
 acquired at:  init_hwif_data+0x94/0x180=0A=0A#005:             [c054eac0] =
{r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:              init/    1 [c1=
795980]=0A... acquired at:  init_hwif_data+0x160/0x180=0A=0A#006:          =
   [c054eca0] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:              =
init/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x160/0x180=0A=0A#=
007:             [c054f544] {r:0,a:-1,&hwif->gendev_rel_sem}=0A.. held by: =
             init/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x94/=
0x180=0A=0A#008:             [c054f14c] {r:0,a:-1,&drive->gendev_rel_sem}=
=0A.. held by:              init/    1 [c1795980]=0A... acquired at:  init_=
hwif_data+0x160/0x180=0A=0A#009:             [c054f32c] {r:0,a:-1,&drive->g=
endev_rel_sem}=0A.. held by:              init/    1 [c1795980]=0A... acqui=
red at:  init_hwif_data+0x160/0x180=0A=0A#010:             [c054fbd0] {r:0,=
a:-1,&hwif->gendev_rel_sem}=0A.. held by:              init/    1 [c1795980=
]=0A... acquired at:  init_hwif_data+0x94/0x180=0A=0A#011:             [c05=
4f7d8] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:              init/  =
  1 [c1795980]=0A... acquired at:  init_hwif_data+0x160/0x180=0A=0A#012:   =
          [c054f9b8] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:       =
       init/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x160/0x180=
=0A=0A#013:             [c055025c] {r:0,a:-1,&hwif->gendev_rel_sem}=0A.. he=
ld by:              init/    1 [c1795980]=0A... acquired at:  init_hwif_dat=
a+0x94/0x180=0A=0A#014:             [c054fe64] {r:0,a:-1,&drive->gendev_rel=
_sem}=0A.. held by:              init/    1 [c1795980]=0A... acquired at:  =
init_hwif_data+0x160/0x180=0A=0A#015:             [c0550044] {r:0,a:-1,&dri=
ve->gendev_rel_sem}=0A.. held by:              init/    1 [c1795980]=0A... =
acquired at:  init_hwif_data+0x160/0x180=0A=0A#016:             [c05508e8] =
{r:0,a:-1,&hwif->gendev_rel_sem}=0A.. held by:              init/    1 [c17=
95980]=0A... acquired at:  init_hwif_data+0x94/0x180=0A=0A#017:            =
 [c05504f0] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:              in=
it/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x160/0x180=0A=0A#01=
8:             [c05506d0] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:  =
            init/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x160/=
0x180=0A=0A#019:             [c0550f74] {r:0,a:-1,&hwif->gendev_rel_sem}=0A=
=2E. held by:              init/    1 [c1795980]=0A... acquired at:  init_h=
wif_data+0x94/0x180=0A=0A#020:             [c0550b7c] {r:0,a:-1,&drive->gen=
dev_rel_sem}=0A.. held by:              init/    1 [c1795980]=0A... acquire=
d at:  init_hwif_data+0x160/0x180=0A=0A#021:             [c0550d5c] {r:0,a:=
-1,&drive->gendev_rel_sem}=0A.. held by:              init/    1 [c1795980]=
=0A... acquired at:  init_hwif_data+0x160/0x180=0A=0A#022:             [c05=
51600] {r:0,a:-1,&hwif->gendev_rel_sem}=0A.. held by:              init/   =
 1 [c1795980]=0A... acquired at:  init_hwif_data+0x94/0x180=0A=0A#023:     =
        [c0551208] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:         =
     init/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x160/0x180=
=0A=0A#024:             [c05513e8] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. h=
eld by:              init/    1 [c1795980]=0A... acquired at:  init_hwif_da=
ta+0x160/0x180=0A=0A#025:             [c0551c8c] {r:0,a:-1,&hwif->gendev_re=
l_sem}=0A.. held by:              init/    1 [c1795980]=0A... acquired at: =
 init_hwif_data+0x94/0x180=0A=0A#026:             [c0551894] {r:0,a:-1,&dri=
ve->gendev_rel_sem}=0A.. held by:              init/    1 [c1795980]=0A... =
acquired at:  init_hwif_data+0x160/0x180=0A=0A#027:             [c0551a74] =
{r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:              init/    1 [c1=
795980]=0A... acquired at:  init_hwif_data+0x160/0x180=0A=0A#028:          =
   [c0552318] {r:0,a:-1,&hwif->gendev_rel_sem}=0A.. held by:              i=
nit/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x94/0x180=0A=0A#02=
9:             [c0551f20] {r:0,a:-1,&drive->gendev_rel_sem}=0A.. held by:  =
            init/    1 [c1795980]=0A... acquired at:  init_hwif_data+0x160/=
0x180=0A=0A#030:             [c0552100] {r:0,a:-1,&drive->gendev_rel_sem}=
=0A.. held by:              init/    1 [c1795980]=0A... acquired at:  init_=
hwif_data+0x160/0x180=0A=0A#031:             [dc787cfc] {r:0,a:-1,&tty->ato=
mic_read}=0A.. held by:             getty/  496 [dcf0e660]=0A... acquired a=
t:  read_chan+0x719/0x770=0A=0A#032:             [dc785cfc] {r:0,a:-1,&tty-=
>atomic_read}=0A.. held by:             getty/  495 [dfac5980]=0A... acquir=
ed at:  read_chan+0x719/0x770=0A=0A#033:             [dc792cfc] {r:0,a:-1,&=
tty->atomic_read}=0A.. held by:             getty/  497 [dcf0f980]=0A... ac=
quired at:  read_chan+0x719/0x770=0A=0A#034:             [dc799cfc] {r:0,a:=
-1,&tty->atomic_read}=0A.. held by:             getty/  498 [dcff3980]=0A..=
=2E acquired at:  read_chan+0x719/0x770=0A=0A#035:             [dc764cfc] {=
r:0,a:-1,&tty->atomic_read}=0A.. held by:             getty/  499 [dcff2660=
]=0A... acquired at:  read_chan+0x719/0x770=0A=0A#036:             [dc7f3cf=
c] {r:0,a:-1,&tty->atomic_read}=0A.. held by:             getty/  500 [dcff=
2cc0]=0A... acquired at:  read_chan+0x719/0x770=0A=0A#037:             [dc0=
2fcfc] {r:0,a:-1,&tty->atomic_read}=0A.. held by:             getty/  501 [=
dd5dc000]=0A... acquired at:  read_chan+0x719/0x770=0A=0A#038:             =
[dbfc1c2c] {r:0,a:-1,&mm->mmap_sem}=0A.. held by:              gzip/  577 [=
dbe82cc0]=0A... acquired at:  do_page_fault+0xef/0x680=0A=0A#039:          =
   [c041f560] {r:0,a:-1,net/core/dev.c:157}=0A.. held by:       ksoftirqd/0=
/    3 [c1794cc0]=0A... acquired at:  netif_receive_skb+0x80/0x200=0A=0A#04=
0:             [c045c780] {r:0,a:-1,inet_proto_lock}=0A.. held by:       ks=
oftirqd/0/    3 [c1794cc0]=0A... acquired at:  ip_local_deliver+0x9e/0x2f0=
=0A=0A#041:             [dbf60ec0] {r:0,a:-1,&((sk)->sk_lock.slock)}=0A.. h=
eld by:       ksoftirqd/0/    3 [c1794cc0]=0A... acquired at:  tcp_v4_rcv+0=
x631/0xa50=0A=0A#042:             [dfee9194] {r:0,a:-1,&dev->xmit_lock}=0A.=
=2E held by:              http/  554 [dcff3320]=0A... acquired at:  qdisc_r=
estart+0x262/0x280=0A=0A#043:             [dfee91d0] {r:0,a:-1,&dev->queue_=
lock}=0A.. held by:       ksoftirqd/0/    3 [c1794cc0]=0A... acquired at:  =
qdisc_restart+0x4a/0x280=0A=0A#044:             [c0454380] {r:0,a:-1,taskli=
st_lock}=0A.. held by:              http/  554 [dcff3320]=0A... acquired at=
:  show_all_locks+0x30/0x130=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=0An.org experimental/main Packages [2204B]=0AGet:2 ht=
tp://http.us.debian.org ../project/experimental/main Packages [116kB]   =0A
--3lcZGd9BuhuYXNfi--
