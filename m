Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288047AbSATHZo>; Sun, 20 Jan 2002 02:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288038AbSATHZe>; Sun, 20 Jan 2002 02:25:34 -0500
Received: from cervnet.com ([216.58.141.4]:31506 "EHLO CervNet.COM")
	by vger.kernel.org with ESMTP id <S288047AbSATHZU>;
	Sun, 20 Jan 2002 02:25:20 -0500
From: "jeev" <naptime@cervnet.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Dan Chen'" <crimsun@email.unc.edu>, <akpm@zip.com.au>
Subject: RE: Linux 2.4.17 problem.
Date: Sat, 19 Jan 2002 23:25:16 -0800
MIME-Version: 1.0
Message-ID: <002401c1a183$9c7cd920$0200a8c0@mainframe>
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_001F_01C1A140.8D55E4C0";
	micalg=SHA1
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020120062620.GA25787@opeth.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C1A140.8D55E4C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

The box is back up, someone rebooted for me from the location.

Unable to handle kernel paging request at virtual address 00400000
c012fce4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012fce4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: ea0c71c0   ecx: ea0c71c0   edx: 00400000
esi: 00000002   edi: ea0c71c0   ebp: 00000000   esp: e6fe5eb8
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 247, stackpage=e6fe5000)
Stack: c012fd0a ea0c71c0 c01308e8 ea0c71c0 ea0c71c0 00001000 c0130988
ea0c71c0 
       c1a83140 00000000 00000000 eedb16f0 c0122509 c1a83140 00000000
00000001 
       c0122523 c1a83140 00000000 c1a83140 c0122666 c1a83140 00000000
e6fe5f44 
Call Trace: [<c012fd0a>] [<c01308e8>] [<c0130988>] [<c0122509>]
[<c0122523>] 
   [<c0122666>] [<c0122711>] [<c01407cc>] [<c013eeac>] [<c01388fc>]
[<c01389d8>] 
   [<c0106e6b>] 
Code: 89 02 c7 41 30 00 00 00 00 51 e8 7d ff ff ff 83 c4 04 c3 89
Error (pclose_local): Oops_decode pclose failed 0xb
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.rlyEvb

>>EIP; c012fce4 <__remove_from_queues+14/30>   <=====
Trace; c012fd0a <remove_from_queues+a/10>
Trace; c01308e8 <discard_buffer+68/80>
Trace; c0130988 <discard_bh_page+38/70>
Trace; c0122508 <do_flushpage+28/30>
Trace; c0122522 <truncate_complete_page+12/50>
Trace; c0122666 <truncate_list_pages+106/170>
Trace; c0122710 <truncate_inode_pages+40/70>
Trace; c01407cc <iput+9c/1d0>
Trace; c013eeac <d_delete+4c/70>
Trace; c01388fc <vfs_unlink+12c/160>
Trace; c01389d8 <sys_unlink+a8/120>
Trace; c0106e6a <system_call+32/38>

Unable to handle kernel paging request at virtual address 0a073344
c013073c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013073c>]    Not tainted
EFLAGS: 00010202
eax: 0a073340   ebx: 00000000   ecx: ea073000   edx: 0a073340
esi: 00000000   edi: 00001000   ebp: 00000001   esp: dd375ea4
ds: 0018   es: 0018   ss: 0018
Process lmdd (pid: 1396, stackpage=dd375000)
Stack: c01307bd 00000001 c1a4adc0 00000301 000011fa c1dc3dc4 c01309d7
c1a4adc0 
       00001000 00000001 00000000 dd375f0c c0130bcb c1a4adc0 00000301
00001000 
       00000000 c1a4adc0 000011fa c1dc3dc4 e92b7000 c0130479 00001000
c01304c6 
Call Trace: [<c01307bd>] [<c01309d7>] [<c0130bcb>] [<c0130479>]
[<c01304c6>] 
   [<c0131222>] [<c0150ce0>] [<c01510b9>] [<c0150ce0>] [<c012542b>]
[<c012eb16>] 
   [<c0106e6b>] 
Code: c7 42 04 ff ff ff ff c7 42 28 00 00 00 00 c3 90 8d 74 26 00 
Error (pclose_local): Oops_decode pclose failed 0xb
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.EItk8d

>>EIP; c013073c <get_unused_buffer_head+3c/80>   <=====
Trace; c01307bc <create_buffers+1c/e0>
Trace; c01309d6 <create_empty_buffers+16/50>
Trace; c0130bca <__block_prepare_write+4a/200>
Trace; c0130478 <balance_dirty_state+18/60>
Trace; c01304c6 <balance_dirty+6/30>
Trace; c0131222 <block_prepare_write+22/40>
Trace; c0150ce0 <ext2_get_block+0/380>
Trace; c01510b8 <ext2_prepare_write+18/20>
Trace; c0150ce0 <ext2_get_block+0/380>
Trace; c012542a <generic_file_write+45a/660>
Trace; c012eb16 <sys_write+96/d0>
Trace; c0106e6a <system_call+32/38>

 <1>Unable to handle kernel paging request at virtual address 2e86369c
c013eb66
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013eb66>]    Not tainted
EFLAGS: 00010202
eax: 00000003   ebx: 2e863640   ecx: 00000000   edx: dd6bdf74
esi: ef8ac009   edi: 2e86369c   ebp: ef72e9c0   esp: dd6bdf14
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 466, stackpage=dd6bd000)
Stack: 00000000 eeec7780 eeec77e8 ef72e9c0 2e86369c c0136d58 ef72e9c0
dd6bdf74 
       dd6bdf74 00000000 dd6bdfa4 eeec7780 c013738e ef72e9c0 dd6bdf74
00000000 
       ef8ac000 00000000 dd6bdfa4 00000009 c0136acd 00000009 ef8ac00c
00000000 
Call Trace: [<c0136d58>] [<c013738e>] [<c0136acd>] [<c01375ca>]
[<c0137955>] 
   [<c0134bf9>] [<c0106e6b>] 
Code: 66 a5 a8 01 74 01 a4 eb 10 90 50 56 8b 44 24 18 50 e8 84 30
Error (pclose_local): Oops_decode pclose failed 0xb
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.9ibQXh

>>EIP; c013eb66 <d_alloc+96/180>   <=====
Trace; c0136d58 <real_lookup+38/c0>
Trace; c013738e <link_path_walk+4be/6e0>
Trace; c0136acc <getname+5c/a0>
Trace; c01375ca <path_walk+1a/20>
Trace; c0137954 <__user_walk+34/50>
Trace; c0134bf8 <sys_stat64+18/70>
Trace; c0106e6a <system_call+32/38>


38 warnings and 8 errors issued.  Results may not be reliable.

j

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Dan Chen
> Sent: Saturday, January 19, 2002 10:26 PM
> To: jeev
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.4.17 problem.
> 
> Would you run those through ksymoops and repost?
> 
> On Sat, Jan 19, 2002 at 09:24:56PM -0800, jeev wrote:
> > Hi, im running slackware with the kernel 2.4.17, when I tar -zxvf a
big
> > file, ie. hlds_l_3108_full.tar.gz.
> >
> > It cuts off saying format violated..
> > This is an amd 1.4ghz with 768 mbram 41gb 7200rpm harddrive (brand
new
> > stuff)
> 
> --
> Dan Chen                 crimsun@email.unc.edu
> GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

------=_NextPart_000_001F_01C1A140.8D55E4C0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII8TCCAoAw
ggHpoAMCAQICAwZBjzANBgkqhkiG9w0BAQIFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAxMTIwNjA2MDYzM1oXDTAyMTIwNjA2MDYzM1owRTEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEiMCAGCSqGSIb3DQEJARYTbmFwdGltZUBjZXJ2bmV0LmNvbTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAz0mQ8rzcTgacUdJdwyW6PzGeYHxOaslWWCUrFmvuaO8q
2NcC8hTieOkuOknDzNz7uUR0ab8n+pXOFYThs1muaMK11VRp4BIkiRJe/41diCSjFWb8X1XhqGpU
pB5DtTHGTT+G6XOa0cCUobIehi8zuP9wRKgkaycNQb8owCQVc8UCAwEAAaMwMC4wHgYDVR0RBBcw
FYETbmFwdGltZUBjZXJ2bmV0LmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBAgUAA4GBAFW+
KAHeKTLKrga03WUsMHpsk9NW77W1nzafKDqyHYnBXp1yJkXYHXfSpBXt1teCJAptPDJ9NKmq54X2
tOCrrkt2tv45La8yPuY17EEeKawK/g2d9hNvuPMh9qfSNoz8XUbviDMpWmrPVuINlFLN1g55kCWq
H13QE06B+sk4AUFzMIIDLTCCApagAwIBAgIBADANBgkqhkiG9w0BAQQFADCB0TELMAkGA1UEBhMC
WkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFU
aGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lv
bjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxw
ZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTk2MDEwMTAwMDAwMFoXDTIwMTIzMTIzNTk1
OVowgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTCBnzANBgkqhkiG9w0B
AQEFAAOBjQAwgYkCgYEA1GnX1LCUZFtx6UfYDFG26nKRsIRefS0Nj3sS34UldSh0OkIsYyeflXtL
734Zhx2G6qPduc6WZBrCFG5ErHzmj+hND3EfQDimAKOHePb5lIZererAXnbr2RSjXW56fAylS1V/
Bhkpf56aJtVquzgkCGqYx7Hao5iR/Xnb5VrEHLkCAwEAAaMTMBEwDwYDVR0TAQH/BAUwAwEB/zAN
BgkqhkiG9w0BAQQFAAOBgQDH7JJ+Tvj1lqVnYiqk8E0RYNBvjWBYYawmu1I1XAjPMPuoSpaKH2JC
I4wXD/S6ZJwXrEcp352YXtJsYHFcoqzceePnbgBHH7UNKOgCneSa/RP0ptl8sfjcXyMmCZGAc9AU
G95DqYMl8uacLxXK/qarigd1iwzdUYRr5PjRzneigTCCAzgwggKhoAMCAQICEGZFcrfMdPXPY3ZF
hNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENh
cGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNV
BAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3Rl
LmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wNDA4MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEd
MBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWls
IFJTQSAyMDAwLjguMzAwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7Sbngn
Z4HF2ogZgpcO40QpimM1Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWa
NRqdknWoJ67Ycvm6AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFp
AgMBAAGjTjBMMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNV
HRMBAf8ECDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1
U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXrokef
bKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXdiuT82w0fnQLzWtvKPPZE6iZph39Ins6ln+eE2Mli
Yq0FxjGCA2kwggNlAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBl
MRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNh
dGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwZB
jzAJBgUrDgMCGgUAoIICJDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0wMjAxMjAwNzI1MTZaMCMGCSqGSIb3DQEJBDEWBBRqOZOCwnO7zw5JlQzIJ1hZbZuHiDBnBgkq
hkiG9w0BCQ8xWjBYMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTCBqwYJKwYBBAGCNxAE
MYGdMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlD
YXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMx
KDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwZBjzCBrQYLKoZIhvcN
AQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNV
BAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2
aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAIDBkGPMA0GCSqG
SIb3DQEBAQUABIGAw4YefU8qVLQtzvoKdEz4g4l4Xl1yT0VD/3gvSvyTZqLQapnY07wiQLvL20hh
xbVmr3C+RB7EfxqS+mq+8OAJtMuLgOLHgX0bOPOZvlYTQBA9sfvl2Ks1OIvwuP8z6Tfhg1p5su14
clyBPF+mBC/ICt6O8qSRAgkIT3Wf+77Vsn8AAAAAAAA=

------=_NextPart_000_001F_01C1A140.8D55E4C0--

