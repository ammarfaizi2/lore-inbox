Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267114AbUBMQri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267124AbUBMQri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:47:38 -0500
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:13964 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id S267114AbUBMQqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:46:02 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310F0B9@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: 
Date: Fri, 13 Feb 2004 08:45:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3F250.D8361FB4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3F250.D8361FB4
Content-Type: text/plain;
	charset="iso-8859-1"

I am running a 2.4.19 Kernel and have a problem where a process is using the
up to the 0xC0000000 of space. It is no longer possible for this process to
get any more memory vi mmap or via shmget. However, when I dump the
/procs/#/maps file, I see large chunks of memory deleted. i.e this should be
freely available to be used by the next call. I do not see these addresses
get re-used. The maps file is attached.

 <<9369>> 

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


------_=_NextPart_000_01C3F250.D8361FB4
Content-Type: application/octet-stream;
	name="9369"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="9369"

08048000-08165000 r-xp 00000000 08:02 1229201    =
/unisphere/srx3000/callp/bin/ucemain=0A=
08165000-08181000 rw-p 0011d000 08:02 1229201    =
/unisphere/srx3000/callp/bin/ucemain=0A=
08181000-08259000 rwxp 00000000 00:00 0=0A=
40000000-40012000 r-xp 00000000 08:02 3473423    /lib/ld-2.2.5.so=0A=
40012000-40013000 rw-p 00011000 08:02 3473423    /lib/ld-2.2.5.so=0A=
40013000-40014000 rw-p 00000000 00:00 0=0A=
40014000-4002d000 r-xp 00000000 08:02 3146425    =
/unisphere/srx3000/callp/lib/libUceMsg.so=0A=
4002d000-40032000 rw-p 00018000 08:02 3146425    =
/unisphere/srx3000/callp/lib/libUceMsg.so=0A=
40032000-4003b000 rw-p 00000000 00:00 0=0A=
4003b000-4014a000 r-xp 00000000 08:02 3146373    =
/unisphere/srx3000/callp/lib/librss.so=0A=
4014a000-40167000 rw-p 0010f000 08:02 3146373    =
/unisphere/srx3000/callp/lib/librss.so=0A=
40167000-40169000 rw-p 00000000 00:00 0=0A=
40169000-40173000 r-xp 00000000 08:02 3146393    =
/unisphere/srx3000/callp/lib/libdbal_no_LDAP.so=0A=
40173000-40174000 rw-p 0000a000 08:02 3146393    =
/unisphere/srx3000/callp/lib/libdbal_no_LDAP.so=0A=
40174000-4017f000 r-xp 00000000 08:02 3146419    =
/unisphere/srx3000/callp/lib/libstormgr.so=0A=
4017f000-40181000 rw-p 0000b000 08:02 3146419    =
/unisphere/srx3000/callp/lib/libstormgr.so=0A=
40181000-40182000 rw-p 00000000 00:00 0=0A=
40182000-40186000 r-xp 00000000 08:02 901822     =
/opt/SMAW/SMAWrtp/lib/libRtpSta.so=0A=
40186000-40187000 rw-p 00004000 08:02 901822     =
/opt/SMAW/SMAWrtp/lib/libRtpSta.so=0A=
40187000-4018d000 r-xp 00000000 08:02 901825     =
/opt/SMAW/SMAWrtp/lib/libRtpTic.so=0A=
4018d000-40190000 rw-p 00006000 08:02 901825     =
/opt/SMAW/SMAWrtp/lib/libRtpTic.so=0A=
40190000-40192000 r-xp 00000000 08:02 901790     =
/opt/SMAW/SMAWrtp/lib/libRtpUtil.so=0A=
40192000-40193000 rw-p 00002000 08:02 901790     =
/opt/SMAW/SMAWrtp/lib/libRtpUtil.so=0A=
40193000-401bf000 r-xp 00000000 08:02 901786     =
/opt/SMAW/SMAWrtp/lib/libRtpTm.so=0A=
401bf000-401c1000 rw-p 0002b000 08:02 901786     =
/opt/SMAW/SMAWrtp/lib/libRtpTm.so=0A=
401c1000-401c9000 rw-p 00000000 00:00 0=0A=
401c9000-40256000 r-xp 00000000 08:02 901780     =
/opt/SMAW/SMAWrtp/lib/libRtpCtx.so=0A=
40256000-40263000 rw-p 0008d000 08:02 901780     =
/opt/SMAW/SMAWrtp/lib/libRtpCtx.so=0A=
40263000-4027b000 rw-p 00000000 00:00 0=0A=
4027b000-4030d000 r-xp 00000000 08:02 901782     =
/opt/SMAW/SMAWrtp/lib/libRtpEvent.so=0A=
4030d000-4031d000 rw-p 00091000 08:02 901782     =
/opt/SMAW/SMAWrtp/lib/libRtpEvent.so=0A=
4031d000-40328000 r-xp 00000000 08:02 901773     =
/opt/SMAW/SMAWrtp/lib/libRtpCfg.so=0A=
40328000-40330000 rw-p 0000b000 08:02 901773     =
/opt/SMAW/SMAWrtp/lib/libRtpCfg.so=0A=
40330000-40331000 rw-p 00000000 00:00 0=0A=
40331000-40341000 r-xp 00000000 08:02 901817     =
/opt/SMAW/SMAWrtp/lib/libRtpDbiSolid.so=0A=
40341000-40342000 rw-p 0000f000 08:02 901817     =
/opt/SMAW/SMAWrtp/lib/libRtpDbiSolid.so=0A=
40342000-40344000 rw-p 00000000 00:00 0=0A=
40344000-4034b000 r-xp 00000000 08:02 901787     =
/opt/SMAW/SMAWrtp/lib/libRtpTrc.so=0A=
4034b000-4034c000 rw-p 00007000 08:02 901787     =
/opt/SMAW/SMAWrtp/lib/libRtpTrc.so=0A=
4034c000-40375000 r-xp 00000000 08:02 901778     =
/opt/SMAW/SMAWrtp/lib/libRtpCom.so=0A=
40375000-40383000 rw-p 00028000 08:02 901778     =
/opt/SMAW/SMAWrtp/lib/libRtpCom.so=0A=
40383000-40386000 r-xp 00000000 08:02 901789     =
/opt/SMAW/SMAWrtp/lib/libRtpUpdate.so=0A=
40386000-4038a000 rw-p 00003000 08:02 901789     =
/opt/SMAW/SMAWrtp/lib/libRtpUpdate.so=0A=
4038a000-4038d000 r-xp 00000000 08:02 901785     =
/opt/SMAW/SMAWrtp/lib/libRtpSnm.so=0A=
4038d000-4038e000 rw-p 00002000 08:02 901785     =
/opt/SMAW/SMAWrtp/lib/libRtpSnm.so=0A=
4038e000-40390000 r-xp 00000000 08:02 901779     =
/opt/SMAW/SMAWrtp/lib/libRtpCommon.so=0A=
40390000-40391000 rw-p 00001000 08:02 901779     =
/opt/SMAW/SMAWrtp/lib/libRtpCommon.so=0A=
40391000-40392000 rw-p 00000000 00:00 0=0A=
40392000-4039b000 r-xp 00000000 08:02 901774     =
/opt/SMAW/SMAWrtp/lib/libRtpCfgAdm.so=0A=
4039b000-403a3000 rw-p 00009000 08:02 901774     =
/opt/SMAW/SMAWrtp/lib/libRtpCfgAdm.so=0A=
403a3000-403a4000 rw-p 00000000 00:00 0=0A=
403a4000-4046d000 r-xp 00000000 08:02 409972     =
/usr/local/solid41/lib/socl2x41.so=0A=
4046d000-40479000 rw-p 000c9000 08:02 409972     =
/usr/local/solid41/lib/socl2x41.so=0A=
40479000-40486000 rw-p 00000000 00:00 0=0A=
40486000-40495000 r-xp 00000000 08:02 3146382    =
/unisphere/srx3000/callp/lib/libSrxCommon.so=0A=
40495000-40498000 rw-p 0000f000 08:02 3146382    =
/unisphere/srx3000/callp/lib/libSrxCommon.so=0A=
40498000-4049a000 r-xp 00000000 08:02 3146384    =
/unisphere/srx3000/callp/lib/libuce.so=0A=
4049a000-4049b000 rw-p 00002000 08:02 3146384    =
/unisphere/srx3000/callp/lib/libuce.so=0A=
4049b000-405a6000 r-xp 00000000 08:02 3146420    =
/unisphere/srx3000/callp/lib/libxla.so=0A=
405a6000-405cb000 rw-p 0010a000 08:02 3146420    =
/unisphere/srx3000/callp/lib/libxla.so=0A=
405cb000-405ce000 rw-p 00000000 00:00 0=0A=
405ce000-405e0000 r-xp 00000000 08:02 3146412    =
/unisphere/srx3000/callp/lib/libCdmInterface.so=0A=
405e0000-405e3000 rw-p 00011000 08:02 3146412    =
/unisphere/srx3000/callp/lib/libCdmInterface.so=0A=
405e3000-40770000 r-xp 00000000 08:02 3146418    =
/unisphere/srx3000/callp/lib/librtm.so=0A=
40770000-4079e000 rw-p 0018c000 08:02 3146418    =
/unisphere/srx3000/callp/lib/librtm.so=0A=
4079e000-4079f000 rw-s 00000000 00:05 7340244    /SYSV580202a1 =
(deleted)=0A=
4079f000-407a0000 rw-s 00000000 00:05 524292     /SYSVa800e006 =
(deleted)=0A=
407a0000-407a1000 rw-p 00000000 00:00 0=0A=
407a1000-407a2000 rw-s 00000000 00:05 7340244    /SYSV580202a1 =
(deleted)=0A=
407a2000-407a3000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
407a3000-407ab000 rw-p 00000000 00:00 0=0A=
407ab000-407ac000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
407ac000-407ad000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
407ad000-407b1000 rw-p 0000a000 00:00 0=0A=
407b1000-407b3000 r-xp 00000000 08:02 3473433    /lib/libdl.so.2=0A=
407b3000-407b4000 rw-p 00001000 08:02 3473433    /lib/libdl.so.2=0A=
407b4000-407b5000 rw-p 00000000 00:00 0=0A=
407b5000-407c7000 r-xp 00000000 08:02 3473436    /lib/libnsl.so.1=0A=
407c7000-407c8000 rw-p 00011000 08:02 3473436    /lib/libnsl.so.1=0A=
407c8000-407ca000 rw-p 00000000 00:00 0=0A=
407ca000-407d1000 r-xp 00000000 08:02 3146383    =
/unisphere/srx3000/callp/lib/libftp.so=0A=
407d1000-407d2000 rw-p 00006000 08:02 3146383    =
/unisphere/srx3000/callp/lib/libftp.so=0A=
407d2000-407f0000 r-xp 00000000 08:02 3146421    =
/unisphere/srx3000/callp/lib/libsdal.so=0A=
407f0000-407f3000 rw-p 0001e000 08:02 3146421    =
/unisphere/srx3000/callp/lib/libsdal.so=0A=
407f3000-4087d000 r-xp 00000000 08:02 3146371    =
/unisphere/srx3000/callp/lib/libinal.so=0A=
4087d000-40889000 rw-p 00089000 08:02 3146371    =
/unisphere/srx3000/callp/lib/libinal.so=0A=
40889000-4088a000 rw-p 00000000 00:00 0=0A=
4088a000-408ca000 r-xp 00000000 08:02 3146427    =
/unisphere/srx3000/callp/lib/libssal.so=0A=
408ca000-408cf000 rw-p 0003f000 08:02 3146427    =
/unisphere/srx3000/callp/lib/libssal.so=0A=
408cf000-40cdb000 rw-p 00000000 00:00 0=0A=
40cdb000-40ce2000 r-xp 00000000 08:02 3146426    =
/unisphere/srx3000/callp/lib/libgenbcid.so=0A=
40ce2000-40ce3000 rw-p 00007000 08:02 3146426    =
/unisphere/srx3000/callp/lib/libgenbcid.so=0A=
40ce3000-40d02000 r-xp 00000000 08:02 3146380    =
/unisphere/srx3000/callp/lib/libSVCcommon.so=0A=
40d02000-40d04000 rw-p 0001f000 08:02 3146380    =
/unisphere/srx3000/callp/lib/libSVCcommon.so=0A=
40d04000-40d05000 rw-p 00000000 00:00 0=0A=
40d05000-40d1e000 r-xp 00000000 08:02 3146372    =
/unisphere/srx3000/callp/lib/libAuthClient.so=0A=
40d1e000-40d20000 rw-p 00018000 08:02 3146372    =
/unisphere/srx3000/callp/lib/libAuthClient.so=0A=
40d20000-40d2e000 r-xp 00000000 08:02 3146410    =
/unisphere/srx3000/callp/lib/libAuc.so=0A=
40d2e000-40d31000 rw-p 0000d000 08:02 3146410    =
/unisphere/srx3000/callp/lib/libAuc.so=0A=
40d31000-40d51000 r-xp 00000000 08:02 3146377    =
/unisphere/srx3000/callp/lib/libCDR.so=0A=
40d51000-40d55000 rw-p 0001f000 08:02 3146377    =
/unisphere/srx3000/callp/lib/libCDR.so=0A=
40d55000-40d57000 rw-p 00000000 00:00 0=0A=
40d57000-40d5b000 r-xp 00000000 08:02 3146408    =
/unisphere/srx3000/callp/lib/libOpRtt.so=0A=
40d5b000-40d5c000 rw-p 00004000 08:02 3146408    =
/unisphere/srx3000/callp/lib/libOpRtt.so=0A=
40d5c000-40d7c000 r-xp 00000000 08:02 3146376    =
/unisphere/srx3000/callp/lib/libSrxTrcMgr.so=0A=
40d7c000-40d7f000 rw-p 0001f000 08:02 3146376    =
/unisphere/srx3000/callp/lib/libSrxTrcMgr.so=0A=
40d7f000-40d80000 rw-p 00000000 00:00 0=0A=
40d80000-40d82000 r-xp 00000000 08:02 3146375    =
/unisphere/srx3000/callp/lib/libSrxTrcCli.so=0A=
40d82000-40d83000 rw-p 00001000 08:02 3146375    =
/unisphere/srx3000/callp/lib/libSrxTrcCli.so=0A=
40d83000-40d8d000 r-xp 00000000 08:02 3146378    =
/unisphere/srx3000/callp/lib/libEM.so=0A=
40d8d000-40d8e000 rw-p 0000a000 08:02 3146378    =
/unisphere/srx3000/callp/lib/libEM.so=0A=
40d8e000-40d8f000 rw-p 00000000 00:00 0=0A=
40d8f000-40da1000 r-xp 00000000 08:02 3146374    =
/unisphere/srx3000/callp/lib/libBgApi.so=0A=
40da1000-40da3000 rw-p 00011000 08:02 3146374    =
/unisphere/srx3000/callp/lib/libBgApi.so=0A=
40da3000-40e0b000 r-xp 00000000 08:02 3146414    =
/unisphere/srx3000/callp/lib/libXdmInterface.so=0A=
40e0b000-40e1d000 rw-p 00067000 08:02 3146414    =
/unisphere/srx3000/callp/lib/libXdmInterface.so=0A=
40e1d000-40eb6000 r-xp 00000000 08:02 1474757    =
/usr/lib/libstdc++.so.5.0.0=0A=
40eb6000-40ecb000 rw-p 00098000 08:02 1474757    =
/usr/lib/libstdc++.so.5.0.0=0A=
40ecb000-40ed0000 rw-p 00000000 00:00 0=0A=
40ed0000-40ef2000 r-xp 00000000 08:02 3473434    /lib/libm.so.6=0A=
40ef2000-40ef3000 rw-p 00021000 08:02 3473434    /lib/libm.so.6=0A=
40ef3000-40efa000 r-xp 00000000 08:02 3473460    /lib/libgcc_s.so.1=0A=
40efa000-40efb000 rw-p 00007000 08:02 3473460    /lib/libgcc_s.so.1=0A=
40efb000-4100f000 r-xp 00000000 08:02 3473429    /lib/libc.so.6=0A=
4100f000-41015000 rw-p 00113000 08:02 3473429    /lib/libc.so.6=0A=
41015000-41019000 rw-p 00000000 00:00 0=0A=
41019000-41027000 r-xp 00000000 08:02 3473445    =
/lib/libpthread.so.0=0A=
41027000-4102e000 rw-p 0000e000 08:02 3473445    =
/lib/libpthread.so.0=0A=
4102e000-41030000 rw-p 00000000 00:00 0=0A=
41030000-63d46000 rw-s 00000000 00:05 6947016    /SYSV01020282 =
(deleted)=0A=
63d46000-63d86000 rw-p 00000000 00:00 0=0A=
63d86000-63d8f000 rw-s 00000000 00:05 753675     /SYSVa8001005 =
(deleted)=0A=
63d8f000-63d90000 rw-s 00000000 00:05 2293818    /SYSVa8006046 =
(deleted)=0A=
63d90000-63d91000 rw-s 00000000 00:05 2326587    /SYSVa8006048 =
(deleted)=0A=
63d91000-63d9a000 r-xp 00000000 08:02 3473440    =
/lib/libnss_files.so.2=0A=
63d9a000-63d9b000 rw-p 00008000 08:02 3473440    =
/lib/libnss_files.so.2=0A=
63d9b000-6455c000 rw-s 00000000 00:05 720906     /SYSVa8001000 =
(deleted)=0A=
6455c000-647b2000 rw-s 00000000 00:05 8257772    /SYSVa8020040 =
(deleted)=0A=
647b2000-65013000 rw-s 00000000 00:05 819213     /SYSVa8001001 =
(deleted)=0A=
65013000-6512d000 rw-s 00000000 00:05 786444     /SYSVa8020000 =
(deleted)=0A=
6512d000-651cf000 rw-s 00000000 00:05 458753     /SYSVa8004001 =
(deleted)=0A=
651cf000-65391000 rw-s 00000000 00:05 2064435    /SYSVa8006000 =
(deleted)=0A=
65391000-653a6000 rw-s 00000000 00:05 2228280    /SYSVa8006003 =
(deleted)=0A=
653a6000-653b1000 rw-s 00000000 00:05 2261049    /SYSVa8006047 =
(deleted)=0A=
653b1000-653b2000 rw-s 00000000 00:05 2359356    /SYSVa8006049 =
(deleted)=0A=
653b2000-653bd000 rw-s 00000000 00:05 2392125    /SYSVa8006051 =
(deleted)=0A=
653bd000-653c0000 rw-s 00000000 00:05 2424894    /SYSVa8006050 =
(deleted)=0A=
653c0000-653c1000 rw-s 00000000 00:05 2457663    /SYSVa8006052 =
(deleted)=0A=
653c1000-653d1000 rw-s 00000000 00:05 2490432    /SYSVa8006053 =
(deleted)=0A=
653d1000-653dc000 rw-s 00000000 00:05 2523201    /SYSVa8006209 =
(deleted)=0A=
653dc000-653f3000 rw-s 00000000 00:05 2555970    /SYSVa8006208 =
(deleted)=0A=
653f3000-653f4000 rw-s 00000000 00:05 2588739    /SYSVa800620a =
(deleted)=0A=
653f4000-654ee000 rw-s 00000000 00:05 2621508    /SYSVa800620b =
(deleted)=0A=
654ee000-65519000 rw-s 00000000 00:05 2654277    /SYSVa8006231 =
(deleted)=0A=
65519000-6589c000 rw-s 00000000 00:05 2687046    /SYSVa8006230 =
(deleted)=0A=
6589c000-6589e000 rw-s 00000000 00:05 2719815    /SYSVa8006232 =
(deleted)=0A=
6589e000-6b614000 rw-s 00000000 00:05 2752584    /SYSVa8006233 =
(deleted)=0A=
6b614000-6b63f000 rw-s 00000000 00:05 2785353    /SYSVa800623b =
(deleted)=0A=
6b63f000-6b9c2000 rw-s 00000000 00:05 2818122    /SYSVa800623a =
(deleted)=0A=
6b9c2000-6b9c4000 rw-s 00000000 00:05 2850891    /SYSVa800623c =
(deleted)=0A=
6b9c4000-6cb51000 rw-s 00000000 00:05 2883660    /SYSVa800623d =
(deleted)=0A=
6cb51000-6cb7c000 rw-s 00000000 00:05 2916429    /SYSVa800624f =
(deleted)=0A=
6cb7c000-6ceff000 rw-s 00000000 00:05 2949198    /SYSVa800624e =
(deleted)=0A=
6ceff000-6cf01000 rw-s 00000000 00:05 2981967    /SYSVa8006250 =
(deleted)=0A=
6cf01000-6d2d2000 rw-s 00000000 00:05 3014736    /SYSVa8006251 =
(deleted)=0A=
6d2d2000-6d2fd000 rw-s 00000000 00:05 3047505    /SYSVa800626d =
(deleted)=0A=
6d2fd000-6d680000 rw-s 00000000 00:05 3080274    /SYSVa800626c =
(deleted)=0A=
6d680000-6d682000 rw-s 00000000 00:05 3113043    /SYSVa800626e =
(deleted)=0A=
6d682000-6e046000 rw-s 00000000 00:05 3145812    /SYSVa800626f =
(deleted)=0A=
6e046000-6e051000 rw-s 00000000 00:05 3178581    /SYSVa8006277 =
(deleted)=0A=
6e051000-6e052000 rw-s 00000000 00:05 3211350    /SYSVa8006276 =
(deleted)=0A=
6e052000-6e053000 rw-s 00000000 00:05 3244119    /SYSVa8006278 =
(deleted)=0A=
6e053000-6e054000 rw-s 00000000 00:05 3276888    /SYSVa8006279 =
(deleted)=0A=
6e054000-6e06f000 rw-s 00000000 00:05 3309657    /SYSVa8006281 =
(deleted)=0A=
6e06f000-6e1e0000 rw-s 00000000 00:05 3342426    /SYSVa8006280 =
(deleted)=0A=
6e1e0000-6e1e1000 rw-s 00000000 00:05 3375195    /SYSVa8006282 =
(deleted)=0A=
6e1e1000-6e9e3000 rw-s 00000000 00:05 3407964    /SYSVa8006283 =
(deleted)=0A=
6e9e3000-6ea0e000 rw-s 00000000 00:05 3440733    /SYSVa800628b =
(deleted)=0A=
6ea0e000-6ed91000 rw-s 00000000 00:05 3473502    /SYSVa800628a =
(deleted)=0A=
6ed91000-6ed93000 rw-s 00000000 00:05 3506271    /SYSVa800628c =
(deleted)=0A=
6ed93000-6ef7c000 rw-s 00000000 00:05 3539040    /SYSVa800628d =
(deleted)=0A=
6ef7c000-6ef87000 rw-s 00000000 00:05 3571809    /SYSVa800629f =
(deleted)=0A=
6ef87000-6ef9e000 rw-s 00000000 00:05 3604578    /SYSVa800629e =
(deleted)=0A=
6ef9e000-6ef9f000 rw-s 00000000 00:05 3637347    /SYSVa80062a0 =
(deleted)=0A=
6ef9f000-6f099000 rw-s 00000000 00:05 3670116    /SYSVa80062a1 =
(deleted)=0A=
6f099000-6f0a4000 rw-s 00000000 00:05 3702885    /SYSVa80062c7 =
(deleted)=0A=
6f0a4000-6f0bb000 rw-s 00000000 00:05 3735654    /SYSVa80062c6 =
(deleted)=0A=
6f0bb000-6f0bc000 rw-s 00000000 00:05 3768423    /SYSVa80062c8 =
(deleted)=0A=
6f0bc000-6fc5f000 rw-s 00000000 00:05 3801192    /SYSVa80062c9 =
(deleted)=0A=
6fc5f000-6fc8a000 rw-s 00000000 00:05 3833961    /SYSVa80062db =
(deleted)=0A=
6fc8a000-7000d000 rw-s 00000000 00:05 3866730    /SYSVa80062da =
(deleted)=0A=
7000d000-7000f000 rw-s 00000000 00:05 3899499    /SYSVa80062dc =
(deleted)=0A=
7000f000-703e0000 rw-s 00000000 00:05 3932268    /SYSVa80062dd =
(deleted)=0A=
703e0000-7040b000 rw-s 00000000 00:05 3965037    /SYSVa80062f9 =
(deleted)=0A=
7040b000-7078e000 rw-s 00000000 00:05 3997806    /SYSVa80062f8 =
(deleted)=0A=
7078e000-70790000 rw-s 00000000 00:05 4030575    /SYSVa80062fa =
(deleted)=0A=
70790000-71154000 rw-s 00000000 00:05 4063344    /SYSVa80062fb =
(deleted)=0A=
71154000-7115f000 rw-s 00000000 00:05 4096113    /SYSVa8006303 =
(deleted)=0A=
7115f000-71160000 rw-s 00000000 00:05 4128882    /SYSVa8006302 =
(deleted)=0A=
71160000-71161000 rw-s 00000000 00:05 4161651    /SYSVa8006304 =
(deleted)=0A=
71161000-71162000 rw-s 00000000 00:05 4194420    /SYSVa8006305 =
(deleted)=0A=
71162000-7117d000 rw-s 00000000 00:05 4227189    /SYSVa800630d =
(deleted)=0A=
7117d000-712ee000 rw-s 00000000 00:05 4259958    /SYSVa800630c =
(deleted)=0A=
712ee000-712ef000 rw-s 00000000 00:05 4292727    /SYSVa800630e =
(deleted)=0A=
712ef000-71af1000 rw-s 00000000 00:05 4325496    /SYSVa800630f =
(deleted)=0A=
71af1000-71b1c000 rw-s 00000000 00:05 4358265    /SYSVa8006317 =
(deleted)=0A=
71b1c000-71e9f000 rw-s 00000000 00:05 4391034    /SYSVa8006316 =
(deleted)=0A=
71e9f000-71ea1000 rw-s 00000000 00:05 4423803    /SYSVa8006318 =
(deleted)=0A=
71ea1000-7208a000 rw-s 00000000 00:05 4456572    /SYSVa8006319 =
(deleted)=0A=
7208a000-720b5000 rw-s 00000000 00:05 4489341    /SYSVa800632b =
(deleted)=0A=
720b5000-72438000 rw-s 00000000 00:05 4522110    /SYSVa800632a =
(deleted)=0A=
72438000-7243a000 rw-s 00000000 00:05 4554879    /SYSVa800632c =
(deleted)=0A=
7243a000-73b1e000 rw-s 00000000 00:05 4587648    /SYSVa800632d =
(deleted)=0A=
73b1e000-73b49000 rw-s 00000000 00:05 4620417    /SYSVa8006335 =
(deleted)=0A=
73b49000-73ecc000 rw-s 00000000 00:05 4653186    /SYSVa8006334 =
(deleted)=0A=
73ecc000-73ece000 rw-s 00000000 00:05 4685955    /SYSVa8006336 =
(deleted)=0A=
73ece000-755b2000 rw-s 00000000 00:05 4718724    /SYSVa8006337 =
(deleted)=0A=
755b2000-755dd000 rw-s 00000000 00:05 4751493    /SYSVa800633f =
(deleted)=0A=
755dd000-75960000 rw-s 00000000 00:05 4784262    /SYSVa800633e =
(deleted)=0A=
75960000-75962000 rw-s 00000000 00:05 4817031    /SYSVa8006340 =
(deleted)=0A=
75962000-78072000 rw-s 00000000 00:05 4849800    /SYSVa8006341 =
(deleted)=0A=
78072000-7809d000 rw-s 00000000 00:05 4882569    /SYSVa8006349 =
(deleted)=0A=
7809d000-78420000 rw-s 00000000 00:05 4915338    /SYSVa8006348 =
(deleted)=0A=
78420000-78422000 rw-s 00000000 00:05 4948107    /SYSVa800634a =
(deleted)=0A=
78422000-7ab32000 rw-s 00000000 00:05 4980876    /SYSVa800634b =
(deleted)=0A=
7ab32000-7ab4d000 rw-s 00000000 00:05 5013645    /SYSVa8006353 =
(deleted)=0A=
7ab4d000-7ae1c000 rw-s 00000000 00:05 5046414    /SYSVa8006352 =
(deleted)=0A=
7ae1c000-7ae1d000 rw-s 00000000 00:05 5079183    /SYSVa8006354 =
(deleted)=0A=
7ae1d000-7ba52000 rw-s 00000000 00:05 5111952    /SYSVa8006355 =
(deleted)=0A=
7ba52000-7ba6d000 rw-s 00000000 00:05 5144721    /SYSVa800635d =
(deleted)=0A=
7ba6d000-7bd3c000 rw-s 00000000 00:05 5177490    /SYSVa800635c =
(deleted)=0A=
7bd3c000-7bd3d000 rw-s 00000000 00:05 5210259    /SYSVa800635e =
(deleted)=0A=
7bd3d000-7c972000 rw-s 00000000 00:05 5243028    /SYSVa800635f =
(deleted)=0A=
7c972000-7c99d000 rw-s 00000000 00:05 5275797    /SYSVa8006367 =
(deleted)=0A=
7c99d000-7cd20000 rw-s 00000000 00:05 5308566    /SYSVa8006366 =
(deleted)=0A=
7cd20000-7cd22000 rw-s 00000000 00:05 5341335    /SYSVa8006368 =
(deleted)=0A=
7cd22000-7deaf000 rw-s 00000000 00:05 5374104    /SYSVa8006369 =
(deleted)=0A=
7deaf000-7deda000 rw-s 00000000 00:05 5406873    /SYSVa8006371 =
(deleted)=0A=
7deda000-7df34000 rw-s 00000000 00:05 5439642    /SYSVa8006370 =
(deleted)=0A=
7df34000-7df35000 rw-s 00000000 00:05 5472411    /SYSVa8006372 =
(deleted)=0A=
7df35000-7dfe4000 rw-s 00000000 00:05 5505180    /SYSVa8006373 =
(deleted)=0A=
7dfe4000-7dfef000 rw-s 00000000 00:05 5537949    /SYSVa800637b =
(deleted)=0A=
7dfef000-7dff0000 rw-s 00000000 00:05 5570718    /SYSVa800637a =
(deleted)=0A=
7dff0000-7dff1000 rw-s 00000000 00:05 5603487    /SYSVa800637c =
(deleted)=0A=
7dff1000-7dff5000 rw-s 00000000 00:05 5636256    /SYSVa800637d =
(deleted)=0A=
7dff5000-7e000000 rw-s 00000000 00:05 5669025    /SYSVa8006385 =
(deleted)=0A=
7e000000-7e001000 rw-s 00000000 00:05 5701794    /SYSVa8006384 =
(deleted)=0A=
7e001000-7e002000 rw-s 00000000 00:05 5734563    /SYSVa8006386 =
(deleted)=0A=
7e002000-7e006000 rw-s 00000000 00:05 5767332    /SYSVa8006387 =
(deleted)=0A=
7e006000-7e031000 rw-s 00000000 00:05 5800101    /SYSVa800638f =
(deleted)=0A=
7e031000-7e3b4000 rw-s 00000000 00:05 5832870    /SYSVa800638e =
(deleted)=0A=
7e3b4000-7e3b6000 rw-s 00000000 00:05 5865639    /SYSVa8006390 =
(deleted)=0A=
7e3b6000-83002000 rw-s 00000000 00:05 5898408    /SYSVa8006391 =
(deleted)=0A=
83002000-8302d000 rw-s 00000000 00:05 5931177    /SYSVa8006399 =
(deleted)=0A=
8302d000-833b0000 rw-s 00000000 00:05 5963946    /SYSVa8006398 =
(deleted)=0A=
833b0000-833b2000 rw-s 00000000 00:05 5996715    /SYSVa800639a =
(deleted)=0A=
833b2000-8453f000 rw-s 00000000 00:05 6029484    /SYSVa800639b =
(deleted)=0A=
8453f000-8456a000 rw-s 00000000 00:05 6062253    /SYSVa80063a3 =
(deleted)=0A=
8456a000-848ed000 rw-s 00000000 00:05 6095022    /SYSVa80063a2 =
(deleted)=0A=
848ed000-848ef000 rw-s 00000000 00:05 6127791    /SYSVa80063a4 =
(deleted)=0A=
848ef000-85a7c000 rw-s 00000000 00:05 6160560    /SYSVa80063a5 =
(deleted)=0A=
85a7c000-85aa7000 rw-s 00000000 00:05 6193329    /SYSVa80063ad =
(deleted)=0A=
85aa7000-85b88000 rw-s 00000000 00:05 6226098    /SYSVa80063ac =
(deleted)=0A=
85b88000-85b89000 rw-s 00000000 00:05 6258867    /SYSVa80063ae =
(deleted)=0A=
85b89000-85beb000 rw-s 00000000 00:05 6291636    /SYSVa80063af =
(deleted)=0A=
85beb000-85c06000 rw-s 00000000 00:05 6324405    /SYSVa80063b7 =
(deleted)=0A=
85c06000-85d77000 rw-s 00000000 00:05 6357174    /SYSVa80063b6 =
(deleted)=0A=
85d77000-85d78000 rw-s 00000000 00:05 6389943    /SYSVa80063b8 =
(deleted)=0A=
85d78000-8657a000 rw-s 00000000 00:05 6422712    /SYSVa80063b9 =
(deleted)=0A=
8657a000-8657b000 r--s 00000000 00:05 0          /SYSV8901a000 =
(deleted)=0A=
8657b000-86587000 rw-s 00000000 00:05 622599     /SYSVa800e001 =
(deleted)=0A=
86587000-86588000 rw-s 00000000 00:05 655368     /SYSVa800e002 =
(deleted)=0A=
86588000-86589000 rw-s 00000000 00:05 1638438    /SYSVa8003000 =
(deleted)=0A=
86589000-8658b000 rw-s 00000000 00:05 1703976    /SYSVa800300a =
(deleted)=0A=
8658b000-8658c000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
8658c000-86594000 rw-p 00004000 00:00 0=0A=
86594000-865cb000 rw-s 00000000 00:05 983058     /SYSVa802000e =
(deleted)=0A=
865cb000-870dc000 rw-s 00000000 00:05 1769514    /SYSVa8003002 =
(deleted)=0A=
870dc000-870de000 rw-s 00000000 00:05 1671207    /SYSVa8003026 =
(deleted)=0A=
870de000-870e2000 rw-p 00000000 00:00 0=0A=
870e2000-871db000 rw-s 00000000 08:02 1262235    =
/unisphere/srx3000/callp/etc/rss/mappedSubEndpointIndexTbl=0A=
871db000-8ab18000 rw-s 00000000 08:02 1262233    =
/unisphere/srx3000/callp/etc/rss/mappedSubSvcTbl=0A=
8ab18000-8afe1000 rw-s 00000000 08:02 1262237    =
/unisphere/srx3000/callp/etc/rss/mappedRetailerSvcTbl=0A=
8afe1000-8b4aa000 rw-s 00000000 08:02 1262239    =
/unisphere/srx3000/callp/etc/rss/mappedRetailerIndexTbl=0A=
8b4aa000-8b5a3000 rw-s 00000000 08:02 1262241    =
/unisphere/srx3000/callp/etc/rss/mappedTimezoneTbl=0A=
8b5a3000-8e557000 rw-s 00000000 08:02 1262243    =
/unisphere/srx3000/callp/etc/rss/mappedSubSipTbl=0A=
8e557000-8e744000 rw-s 00000000 08:02 1262245    =
/unisphere/srx3000/callp/etc/rss/mappedSysSipTbl=0A=
8e744000-8e931000 rw-s 00000000 08:02 1262247    =
/unisphere/srx3000/callp/etc/rss/mappedSysSipIndexTbl=0A=
8e931000-8ea2a000 rw-s 00000000 08:02 1262249    =
/unisphere/srx3000/callp/etc/rss/mappedBGBusinessGrpTbl=0A=
8ea2a000-8eb23000 rw-s 00000000 08:02 1262251    =
/unisphere/srx3000/callp/etc/rss/mappedBGMainNumTbl=0A=
8eb23000-8ec1c000 rw-s 00000000 08:02 1262253    =
/unisphere/srx3000/callp/etc/rss/mappedBGDialPlanTbl=0A=
8ec1c000-8ed15000 rw-s 00000000 08:02 1262255    =
/unisphere/srx3000/callp/etc/rss/mappedBGSvcTbl=0A=
8ed15000-8ee0e000 rw-s 00000000 08:02 1262257    =
/unisphere/srx3000/callp/etc/rss/mappedBGTrafficCountTbl=0A=
8ee0e000-8ef07000 rw-s 00000000 08:02 1262259    =
/unisphere/srx3000/callp/etc/rss/mappedTeenChildTbl=0A=
8ef07000-8f000000 rw-s 00000000 08:02 1262261    =
/unisphere/srx3000/callp/etc/rss/mappedTeenParentTbl=0A=
8f000000-8f0f9000 rw-s 00000000 08:02 1262263    =
/unisphere/srx3000/callp/etc/rss/mappedBGAttendantNumTbl=0A=
8f0f9000-8f1f2000 rw-s 00000000 08:02 1262265    =
/unisphere/srx3000/callp/etc/rss/mappedBGSvcAccessCodeTbl=0A=
8f1f2000-8f6bb000 rw-s 00000000 08:02 1262267    =
/unisphere/srx3000/callp/etc/rss/mappedKeysetInfoTbl=0A=
8f6bb000-8fb84000 rw-s 00000000 08:02 1262269    =
/unisphere/srx3000/callp/etc/rss/mappedCustomerTbl=0A=
8fb84000-9004d000 rw-s 00000000 08:02 1262271    =
/unisphere/srx3000/callp/etc/rss/mappedNumberPlanTbl=0A=
9004d000-9004e000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
9004e000-90052000 rw-p 00000000 00:00 0=0A=
90052000-9007e000 rw-s 00000000 00:05 1966128    /SYSVa8005000 =
(deleted)=0A=
9007e000-9007f000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
9007f000-90097000 rw-p 00001000 00:00 0=0A=
90097000-900bc000 rw-s 00000000 00:05 1409055    /SYSVa8020018 =
(deleted)=0A=
900bc000-b2dd2000 rw-s 00000000 00:05 6947016    /SYSV01020282 =
(deleted)=0A=
b2dd2000-b2dd6000 rw-p 00000000 00:00 0=0A=
b2dd6000-b2ecf000 rw-s 00000000 08:02 2343590    =
/unisphere/srx3000/callp/etc/xla/mappedDomainTbl=0A=
b2ecf000-b46ab000 rw-s 00000000 08:02 2343592    =
/unisphere/srx3000/callp/etc/xla/mappedZoneTbl=0A=
b46ab000-b5039000 rw-s 00000000 08:02 2343594    =
/unisphere/srx3000/callp/etc/xla/mappedE164DestTbl=0A=
b5039000-b55f6000 rw-s 00000000 08:02 2343596    =
/unisphere/srx3000/callp/etc/xla/mappedTODDestTbl=0A=
b55f6000-b6449000 rw-s 00000000 08:02 2343600    =
/unisphere/srx3000/callp/etc/xla/mappedHomeDnTbl=0A=
b6449000-b729c000 rw-s 00000000 08:02 2343602    =
/unisphere/srx3000/callp/etc/xla/mappedPNPCodeTbl=0A=
b729c000-b757d000 rw-s 00000000 08:02 2343598    =
/unisphere/srx3000/callp/etc/xla/mappedE164PrefixTbl=0A=
b757d000-b7a46000 rw-s 00000000 08:02 2343604    =
/unisphere/srx3000/callp/etc/xla/mappedCarrDestTbl=0A=
b7a46000-b7a4d000 rw-s 00000000 08:02 2343606    =
/unisphere/srx3000/callp/etc/xla/mappedChargeRateTbl=0A=
b7a4d000-b9229000 rw-s 00000000 08:02 2343608    =
/unisphere/srx3000/callp/etc/xla/mappedIntcptTbl=0A=
b9229000-b9246000 rw-s 00000000 08:02 2343610    =
/unisphere/srx3000/callp/etc/xla/mappedNtmOmTbl=0A=
b9246000-ba55d000 rw-s 00000000 08:02 2343612    =
/unisphere/srx3000/callp/etc/xla/mappedE164DnTbl=0A=
ba55d000-ba569000 rw-p 00000000 00:00 0=0A=
ba569000-bd51d000 rw-s 00000000 08:02 1737316    =
/unisphere/srx3000/callp/etc/sdal/mappedSvcData=0A=
bd51d000-bd9e6000 rw-s 00000000 08:02 1917616    =
/unisphere/srx3000/callp/etc/ssal/mappedCallData=0A=
bd9e6000-bdeaf000 rw-s 00000000 08:02 1917618    =
/unisphere/srx3000/callp/etc/ssal/mappedCpuRingList=0A=
bdeaf000-bdebb000 rw-s 00000000 08:02 672432     =
/global/user/bcid/mappedBcidCountData=0A=
bdebb000-bdebc000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bdebc000-bdec8000 rw-p 00001000 00:00 0=0A=
bdec8000-bdee5000 rw-s 00000000 08:02 639428     =
/unisphere/srx3000/callp/etc/inal/mappedINFaultHandlingTbl=0A=
bdee5000-bdf02000 rw-s 00000000 08:02 639477     =
/unisphere/srx3000/callp/etc/inal/mappedINSvcLogicHostRouteTbl=0A=
bdf02000-bdf1f000 rw-s 00000000 08:02 639479     =
/unisphere/srx3000/callp/etc/inal/mappedINEscCodeGrpTbl=0A=
bdf1f000-bdf3c000 rw-s 00000000 08:02 639481     =
/unisphere/srx3000/callp/etc/inal/mappedINEscCodeEntryTbl=0A=
bdf3c000-bdfbb000 rw-s 00000000 08:02 639483     =
/unisphere/srx3000/callp/etc/inal/mappedINTriggerTbl=0A=
bdfbb000-be0b4000 rw-s 00000000 08:02 639485     =
/unisphere/srx3000/callp/etc/inal/mappedINProfileTbl=0A=
be0b4000-be57d000 rw-s 00000000 08:02 639487     =
/unisphere/srx3000/callp/etc/inal/mappedINProfileTrigTbl=0A=
be57d000-be59a000 r-xp 00000000 08:02 3244502    =
/unisphere/srx3000/callp/lib/services/libSVCac.so=0A=
be59a000-be59d000 rw-p 0001d000 08:02 3244502    =
/unisphere/srx3000/callp/lib/services/libSVCac.so=0A=
be59d000-be59e000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
be59e000-be5b2000 rw-p 00001000 00:00 0=0A=
be5b2000-be5d6000 r-xp 00000000 08:02 3244503    =
/unisphere/srx3000/callp/lib/services/libSVCacr.so=0A=
be5d6000-be5d9000 rw-p 00024000 08:02 3244503    =
/unisphere/srx3000/callp/lib/services/libSVCacr.so=0A=
be5d9000-be5e5000 rw-p 00000000 00:00 0=0A=
be5e5000-be63c000 r-xp 00000000 08:02 3244504    =
/unisphere/srx3000/callp/lib/services/libSVCin.so=0A=
be63c000-be643000 rw-p 00057000 08:02 3244504    =
/unisphere/srx3000/callp/lib/services/libSVCin.so=0A=
be643000-be663000 r-xp 00000000 08:02 3244505    =
/unisphere/srx3000/callp/lib/services/libSVCar.so=0A=
be663000-be666000 rw-p 0001f000 08:02 3244505    =
/unisphere/srx3000/callp/lib/services/libSVCar.so=0A=
be666000-be667000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
be667000-be668000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
be668000-be67c000 rw-p 00001000 00:00 0=0A=
be67c000-be689000 r-xp 00000000 08:02 3244506    =
/unisphere/srx3000/callp/lib/services/libSVCmn.so=0A=
be689000-be68a000 rw-p 0000d000 08:02 3244506    =
/unisphere/srx3000/callp/lib/services/libSVCmn.so=0A=
be68a000-be69b000 r-xp 00000000 08:02 3244507    =
/unisphere/srx3000/callp/lib/services/libSVCbgsr.so=0A=
be69b000-be69d000 rw-p 00010000 08:02 3244507    =
/unisphere/srx3000/callp/lib/services/libSVCbgsr.so=0A=
be69d000-be6a8000 r-xp 00000000 08:02 3244508    =
/unisphere/srx3000/callp/lib/services/libSVCbgsvc.so=0A=
be6a8000-be6a9000 rw-p 0000a000 08:02 3244508    =
/unisphere/srx3000/callp/lib/services/libSVCbgsvc.so=0A=
be6a9000-be6ba000 r-xp 00000000 08:02 3244509    =
/unisphere/srx3000/callp/lib/services/libSVCblv.so=0A=
be6ba000-be6bc000 rw-p 00010000 08:02 3244509    =
/unisphere/srx3000/callp/lib/services/libSVCblv.so=0A=
be6bc000-be6f7000 r-xp 00000000 08:02 3244512    =
/unisphere/srx3000/callp/lib/services/caleaaf.so=0A=
be6f7000-be6fd000 rw-p 0003b000 08:02 3244512    =
/unisphere/srx3000/callp/lib/services/caleaaf.so=0A=
be6fd000-be70b000 r-xp 00000000 08:02 3244513    =
/unisphere/srx3000/callp/lib/services/libSVCccw.so=0A=
be70b000-be70d000 rw-p 0000d000 08:02 3244513    =
/unisphere/srx3000/callp/lib/services/libSVCccw.so=0A=
be70d000-be774000 r-xp 00000000 08:02 3244514    =
/unisphere/srx3000/callp/lib/services/libSVCcf.so=0A=
be774000-be77c000 rw-p 00067000 08:02 3244514    =
/unisphere/srx3000/callp/lib/services/libSVCcf.so=0A=
be77c000-be780000 rw-p 00000000 00:00 0=0A=
be780000-be7af000 r-xp 00000000 08:02 3244515    =
/unisphere/srx3000/callp/lib/services/libSVCchd.so=0A=
be7af000-be7b3000 rw-p 0002f000 08:02 3244515    =
/unisphere/srx3000/callp/lib/services/libSVCchd.so=0A=
be7b3000-be7bd000 r-xp 00000000 08:02 3244516    =
/unisphere/srx3000/callp/lib/services/libSVCcidcw.so=0A=
be7bd000-be7be000 rw-p 00009000 08:02 3244516    =
/unisphere/srx3000/callp/lib/services/libSVCcidcw.so=0A=
be7be000-be7cb000 r-xp 00000000 08:02 3244517    =
/unisphere/srx3000/callp/lib/services/libSVCcid.so=0A=
be7cb000-be7cc000 rw-p 0000d000 08:02 3244517    =
/unisphere/srx3000/callp/lib/services/libSVCcid.so=0A=
be7cc000-be7d8000 r-xp 00000000 08:02 3244518    =
/unisphere/srx3000/callp/lib/services/libSVCcidsd.so=0A=
be7d8000-be7da000 rw-p 0000b000 08:02 3244518    =
/unisphere/srx3000/callp/lib/services/libSVCcidsd.so=0A=
be7da000-be7e6000 r-xp 00000000 08:02 3244519    =
/unisphere/srx3000/callp/lib/services/libSVCcidss.so=0A=
be7e6000-be7e8000 rw-p 0000b000 08:02 3244519    =
/unisphere/srx3000/callp/lib/services/libSVCcidss.so=0A=
be7e8000-be7f8000 r-xp 00000000 08:02 3244520    =
/unisphere/srx3000/callp/lib/services/libSVCcisname.so=0A=
be7f8000-be7fa000 rw-p 0000f000 08:02 3244520    =
/unisphere/srx3000/callp/lib/services/libSVCcisname.so=0A=
be7fa000-be808000 r-xp 00000000 08:02 3244521    =
/unisphere/srx3000/callp/lib/services/libSVCcisnum.so=0A=
be808000-be80a000 rw-p 0000d000 08:02 3244521    =
/unisphere/srx3000/callp/lib/services/libSVCcisnum.so=0A=
be80a000-be83d000 r-xp 00000000 08:02 3244522    =
/unisphere/srx3000/callp/lib/services/libSVCct.so=0A=
be83d000-be841000 rw-p 00033000 08:02 3244522    =
/unisphere/srx3000/callp/lib/services/libSVCct.so=0A=
be841000-be851000 r-xp 00000000 08:02 3244523    =
/unisphere/srx3000/callp/lib/services/libSVCcm.so=0A=
be851000-be853000 rw-p 0000f000 08:02 3244523    =
/unisphere/srx3000/callp/lib/services/libSVCcm.so=0A=
be853000-be85f000 r-xp 00000000 08:02 3244524    =
/unisphere/srx3000/callp/lib/services/libSVCcnab.so=0A=
be85f000-be861000 rw-p 0000b000 08:02 3244524    =
/unisphere/srx3000/callp/lib/services/libSVCcnab.so=0A=
be861000-be874000 r-xp 00000000 08:02 3244525    =
/unisphere/srx3000/callp/lib/services/libSVCcnam.so=0A=
be874000-be876000 rw-p 00012000 08:02 3244525    =
/unisphere/srx3000/callp/lib/services/libSVCcnam.so=0A=
be876000-be882000 r-xp 00000000 08:02 3244526    =
/unisphere/srx3000/callp/lib/services/libSVCcndb.so=0A=
be882000-be884000 rw-p 0000b000 08:02 3244526    =
/unisphere/srx3000/callp/lib/services/libSVCcndb.so=0A=
be884000-be8b4000 r-xp 00000000 08:02 3244527    =
/unisphere/srx3000/callp/lib/services/libSVCcpk.so=0A=
be8b4000-be8b8000 rw-p 0002f000 08:02 3244527    =
/unisphere/srx3000/callp/lib/services/libSVCcpk.so=0A=
be8b8000-be8b9000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
be8b9000-be8ba000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
be8ba000-be8d6000 rw-p 00001000 00:00 0=0A=
be8d6000-be8fd000 r-xp 00000000 08:02 3244528    =
/unisphere/srx3000/callp/lib/services/libSVCcpu.so=0A=
be8fd000-be900000 rw-p 00027000 08:02 3244528    =
/unisphere/srx3000/callp/lib/services/libSVCcpu.so=0A=
be900000-be959000 r-xp 00000000 08:02 3244529    =
/unisphere/srx3000/callp/lib/services/libSVCcsta.so=0A=
be959000-be961000 rw-p 00059000 08:02 3244529    =
/unisphere/srx3000/callp/lib/services/libSVCcsta.so=0A=
be961000-be962000 rw-p 00000000 00:00 0=0A=
be962000-be96b000 r-xp 00000000 08:02 3244530    =
/unisphere/srx3000/callp/lib/services/libSVCcvb.so=0A=
be96b000-be96c000 rw-p 00009000 08:02 3244530    =
/unisphere/srx3000/callp/lib/services/libSVCcvb.so=0A=
be96c000-be96d000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
be96d000-be979000 rw-p 00001000 00:00 0=0A=
be979000-be986000 r-xp 00000000 08:02 3244531    =
/unisphere/srx3000/callp/lib/services/libSVCcwt.so=0A=
be986000-be987000 rw-p 0000d000 08:02 3244531    =
/unisphere/srx3000/callp/lib/services/libSVCcwt.so=0A=
be987000-be9a6000 r-xp 00000000 08:02 3244532    =
/unisphere/srx3000/callp/lib/services/libSVCdrcw.so=0A=
be9a6000-be9a9000 rw-p 0001e000 08:02 3244532    =
/unisphere/srx3000/callp/lib/services/libSVCdrcw.so=0A=
be9a9000-bea14000 r-xp 00000000 08:02 3244550    =
/unisphere/srx3000/callp/lib/services/libSVCsle.so=0A=
bea14000-bea1d000 rw-p 0006b000 08:02 3244550    =
/unisphere/srx3000/callp/lib/services/libSVCsle.so=0A=
bea1d000-bea29000 rw-p 00000000 00:00 0=0A=
bea29000-bea49000 r-xp 00000000 08:02 3244533    /unisphere/srx3000/call=
p/lib/services/libSVCeacr.so=0A=
bea49000-bea4c000 rw-p 00020000 08:02 3244533    =
/unisphere/srx3000/callp/lib/services/libSVCeacr.so=0A=
bea4c000-bea4d000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bea4d000-bea4e000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bea4e000-bea6a000 rw-p 00001000 00:00 0=0A=
bea6a000-bea77000 r-xp 00000000 08:02 3244534    =
/unisphere/srx3000/callp/lib/services/libSVCecf.so=0A=
bea77000-bea79000 rw-p 0000d000 08:02 3244534    =
/unisphere/srx3000/callp/lib/services/libSVCecf.so=0A=
bea79000-bea8d000 r-xp 00000000 08:02 3244535    =
/unisphere/srx3000/callp/lib/services/libSVCems.so=0A=
bea8d000-bea8f000 rw-p 00013000 08:02 3244535    =
/unisphere/srx3000/callp/lib/services/libSVCems.so=0A=
bea8f000-beaa8000 r-xp 00000000 08:02 3244536    =
/unisphere/srx3000/callp/lib/services/libSVCkey.so=0A=
beaa8000-beaab000 rw-p 00018000 08:02 3244536    =
/unisphere/srx3000/callp/lib/services/libSVCkey.so=0A=
beaab000-beab8000 r-xp 00000000 08:02 3244537    =
/unisphere/srx3000/callp/lib/services/libSVClnp.so=0A=
beab8000-beaba000 rw-p 0000c000 08:02 3244537    =
/unisphere/srx3000/callp/lib/services/libSVClnp.so=0A=
beaba000-bead0000 r-xp 00000000 08:02 3244538    =
/unisphere/srx3000/callp/lib/services/libSVCmct.so=0A=
bead0000-bead2000 rw-p 00015000 08:02 3244538    =
/unisphere/srx3000/callp/lib/services/libSVCmct.so=0A=
bead2000-bead3000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bead3000-beae2000 rw-p 00001000 00:00 0=0A=
beae2000-beb43000 r-xp 00000000 08:02 3244539    =
/unisphere/srx3000/callp/lib/services/libSVCmlhg.so=0A=
beb43000-beb4a000 rw-p 00061000 08:02 3244539    =
/unisphere/srx3000/callp/lib/services/libSVCmlhg.so=0A=
beb4a000-beb72000 r-xp 00000000 08:02 3146400    =
/unisphere/srx3000/callp/lib/libMLHGSMif.so=0A=
beb72000-beb77000 rw-p 00028000 08:02 3146400    =
/unisphere/srx3000/callp/lib/libMLHGSMif.so=0A=
beb77000-beb7c000 rw-p 00000000 00:00 0=0A=
beb7c000-beb84000 r-xp 00000000 08:02 3244541    =
/unisphere/srx3000/callp/lib/services/libSVCpmcnab.so=0A=
beb84000-beb85000 rw-p 00008000 08:02 3244541    =
/unisphere/srx3000/callp/lib/services/libSVCpmcnab.so=0A=
beb85000-beb8b000 rw-p 00000000 00:00 0=0A=
beb8b000-beb9a000 r-xp 00000000 08:02 3473446    /lib/libresolv.so.2=0A=
beb9a000-beb9b000 rw-p 0000e000 08:02 3473446    /lib/libresolv.so.2=0A=
beb9b000-beb9d000 rw-p 00000000 00:00 0=0A=
beb9d000-bebbf000 r-xp 00000000 08:02 3244540    =
/unisphere/srx3000/callp/lib/services/libSVCms.so=0A=
bebbf000-bebc2000 rw-p 00021000 08:02 3244540    =
/unisphere/srx3000/callp/lib/services/libSVCms.so=0A=
bebc2000-bebcc000 r-xp 00000000 08:02 3244542    =
/unisphere/srx3000/callp/lib/services/libSVCpmcndb.so=0A=
bebcc000-bebcd000 rw-p 0000a000 08:02 3244542    =
/unisphere/srx3000/callp/lib/services/libSVCpmcndb.so=0A=
bebcd000-bebdd000 r-xp 00000000 08:02 3244543    =
/unisphere/srx3000/callp/lib/services/libSVCracf.so=0A=
bebdd000-bebdf000 rw-p 00010000 08:02 3244543    =
/unisphere/srx3000/callp/lib/services/libSVCracf.so=0A=
bebdf000-bebf7000 rw-p 00000000 00:00 0=0A=
bebf7000-bec03000 r-xp 00000000 08:02 3244544    =
/unisphere/srx3000/callp/lib/services/libSVCrcf.so=0A=
bec03000-bec04000 rw-p 0000c000 08:02 3244544    =
/unisphere/srx3000/callp/lib/services/libSVCrcf.so=0A=
bec04000-bec15000 r-xp 00000000 08:02 3244545    =
/unisphere/srx3000/callp/lib/services/libSVCrfa.so=0A=
bec15000-bec17000 rw-p 00010000 08:02 3244545    =
/unisphere/srx3000/callp/lib/services/libSVCrfa.so=0A=
bec17000-bec29000 rw-p 00000000 00:00 0=0A=
bec29000-bec4f000 r-xp 00000000 08:02 3244546    =
/unisphere/srx3000/callp/lib/services/libSVCsca.so=0A=
bec4f000-bec53000 rw-p 00025000 08:02 3244546    =
/unisphere/srx3000/callp/lib/services/libSVCsca.so=0A=
bec53000-bec54000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bec54000-bec58000 rw-p 00000000 00:00 0=0A=
bec58000-bec76000 r-xp 00000000 08:02 3244547    =
/unisphere/srx3000/callp/lib/services/libSVCscf.so=0A=
bec76000-bec79000 rw-p 0001d000 08:02 3244547    =
/unisphere/srx3000/callp/lib/services/libSVCscf.so=0A=
bec79000-bec7a000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bec7a000-bec7b000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bec7b000-bec87000 rw-p 00001000 00:00 0=0A=
bec87000-becb2000 r-xp 00000000 08:02 3244548    =
/unisphere/srx3000/callp/lib/services/libSVCsc.so=0A=
becb2000-becb6000 rw-p 0002b000 08:02 3244548    =
/unisphere/srx3000/callp/lib/services/libSVCsc.so=0A=
becb6000-becb7000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
becb7000-becd3000 rw-p 00001000 00:00 0=0A=
becd3000-becf6000 r-xp 00000000 08:02 3244549    =
/unisphere/srx3000/callp/lib/services/libSVCscr.so=0A=
becf6000-becf9000 rw-p 00023000 08:02 3244549    =
/unisphere/srx3000/callp/lib/services/libSVCscr.so=0A=
becf9000-becfa000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
becfa000-bed06000 rw-p 00001000 00:00 0=0A=
bed06000-bed07000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bed07000-bed13000 rw-p 0000e000 00:00 0=0A=
bed13000-bed43000 r-xp 00000000 08:02 3244551    =
/unisphere/srx3000/callp/lib/services/libSVCsrs.so=0A=
bed43000-bed48000 rw-p 00030000 08:02 3244551    =
/unisphere/srx3000/callp/lib/services/libSVCsrs.so=0A=
bed48000-bed49000 rw-p 00000000 00:00 0=0A=
bed49000-bed4a000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bed4a000-bed56000 rw-p 00002000 00:00 0=0A=
bed56000-bed61000 r-xp 00000000 08:02 3244555    =
/unisphere/srx3000/callp/lib/services/libSVCteen.so=0A=
bed61000-bed62000 rw-p 0000b000 08:02 3244555    =
/unisphere/srx3000/callp/lib/services/libSVCteen.so=0A=
bed62000-bed63000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bed63000-bed7f000 rw-p 00001000 00:00 0=0A=
bed7f000-bed8e000 r-xp 00000000 08:02 3244556    =
/unisphere/srx3000/callp/lib/services/libSVCtfs.so=0A=
bed8e000-bed90000 rw-p 0000e000 08:02 3244556    =
/unisphere/srx3000/callp/lib/services/libSVCtfs.so=0A=
bed90000-bed9e000 r-xp 00000000 08:02 3244557    =
/unisphere/srx3000/callp/lib/services/libSVCtpcc.so=0A=
bed9e000-beda0000 rw-p 0000d000 08:02 3244557    =
/unisphere/srx3000/callp/lib/services/libSVCtpcc.so=0A=
beda0000-bedab000 r-xp 00000000 08:02 3244558    =
/unisphere/srx3000/callp/lib/services/libSVCtrs.so=0A=
bedab000-bedac000 rw-p 0000b000 08:02 3244558    =
/unisphere/srx3000/callp/lib/services/libSVCtrs.so=0A=
bedac000-bedad000 rw-s 00000000 00:05 6848709    /SYSV28024276 =
(deleted)=0A=
bedad000-bedb9000 rw-p 00001000 00:00 0=0A=
bedb9000-bedeb000 r-xp 00000000 08:02 3244559    =
/unisphere/srx3000/callp/lib/services/libSVCtwc.so=0A=
bedeb000-bedef000 rw-p 00031000 08:02 3244559    =
/unisphere/srx3000/callp/lib/services/libSVCtwc.so=0A=
bedef000-bee05000 r-xp 00000000 08:02 3244561    =
/unisphere/srx3000/callp/lib/services/libSVCuscn.so=0A=
bee05000-bee07000 rw-p 00015000 08:02 3244561    =
/unisphere/srx3000/callp/lib/services/libSVCuscn.so=0A=
bee07000-bee13000 rw-p 00000000 00:00 0=0A=
bee13000-bee2c000 rw-s 00000000 00:05 7405782    /SYSVa8020046 =
(deleted)=0A=
bee2c000-bee2d000 rw-p 00000000 00:00 0=0A=
bee30000-bee48000 rw-p 00004000 00:00 0=0A=
bff2e000-c0000000 rwxp fff2f000 00:00 0=0A=

------_=_NextPart_000_01C3F250.D8361FB4--
