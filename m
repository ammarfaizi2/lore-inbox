Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130909AbRBWDPl>; Thu, 22 Feb 2001 22:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131002AbRBWDPa>; Thu, 22 Feb 2001 22:15:30 -0500
Received: from web9205.mail.yahoo.com ([216.136.129.38]:9233 "HELO
	web9205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130909AbRBWDPW>; Thu, 22 Feb 2001 22:15:22 -0500
Message-ID: <20010223031521.93782.qmail@web9205.mail.yahoo.com>
Date: Thu, 22 Feb 2001 19:15:21 -0800 (PST)
From: bradley mclain <bradley_kernel@yahoo.com>
Subject: APM suspend system lockup under 2.4.2 and 2.4.2ac1
To: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1024766732-982898121=:92642"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1024766732-982898121=:92642
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

apm --suspend causes my system to hang under 2.4.2 and
2.4.2ac1.  it was working fine under 2.4.1ac19. 
looking at syslog it appears that the driver for my
xircom pcmcia card may be involved -- it was the last
entry on two of three occasions.  the latest lockup
(under 2.4.1ac1) left no trace in syslog.

upon issuing the command the screen shuts down, but
the rest of the machine (drive, etc.) fails to, and i
cannot get control back.

machine:  toshiba tecra 8100

lspci output and two syslog entries are in the
attached file.

1st syslog shows last entry and first of reboot under
2.4.2 and 2nd shows last entry and first of reboot
under 2.4.2ac1.

if anything else is needed, please let me know.

bradley mclain



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices! http://auctions.yahoo.com/
--0-1024766732-982898121=:92642
Content-Type: application/octet-stream; name=extract
Content-Transfer-Encoding: base64
Content-Description: extract
Content-Disposition: attachment; filename=extract

RmViIDIyIDE3OjIwOjAwIGxvY2FsaG9zdCBDUk9ORFsxMzI2XTogKHJvb3Qp
IENNRCAoICAgL3NiaW4vcm1tb2QgLWFzKSAKRmViIDIyIDE3OjIzOjQ5IGxv
Y2FsaG9zdCBjYXJkbWdyWzM4MF06IGV4ZWN1dGluZzogJy4vbmV0d29yayBz
dXNwZW5kIGV0aDAnCkZlYiAyMiAxNzo0NTo1MSBsb2NhbGhvc3Qgc3lzbG9n
ZCAxLjMtMzogcmVzdGFydC4KCkZlYiAyMiAxODoxMzo1OSBsb2NhbGhvc3Qg
cmM6IFN0YXJ0aW5nIGxpbnV4Y29uZiBzdWNjZWVkZWQKRmViIDIyIDE4OjIy
OjExIGxvY2FsaG9zdCBzeXNsb2dkIDEuMy0zOiByZXN0YXJ0LgoKMDA6MDAu
MCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gNDQwQlgvWlggLSA4
MjQ0M0JYL1pYIEhvc3QgYnJpZGdlIChyZXYgMDMpCjAwOjAxLjAgUENJIGJy
aWRnZTogSW50ZWwgQ29ycG9yYXRpb24gNDQwQlgvWlggLSA4MjQ0M0JYL1pY
IEFHUCBicmlkZ2UgKHJldiAwMykKMDA6MDUuMCBCcmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIDgyMzcxQUIgUElJWDQgSVNBIChyZXYgMDIpCjAwOjA1LjEg
SURFIGludGVyZmFjZTogSW50ZWwgQ29ycG9yYXRpb24gODIzNzFBQiBQSUlY
NCBJREUgKHJldiAwMSkKMDA6MDUuMiBVU0IgQ29udHJvbGxlcjogSW50ZWwg
Q29ycG9yYXRpb24gODIzNzFBQiBQSUlYNCBVU0IgKHJldiAwMSkKMDA6MDUu
MyBCcmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIDgyMzcxQUIgUElJWDQgQUNQ
SSAocmV2IDAzKQowMDowNy4wIENvbW11bmljYXRpb24gY29udHJvbGxlcjog
THVjZW50IE1pY3JvZWxlY3Ryb25pY3MgNTZrIFdpbk1vZGVtIChyZXYgMDEp
CjAwOjA5LjAgSVJEQSBjb250cm9sbGVyOiBUb3NoaWJhIEFtZXJpY2EgSW5m
byBTeXN0ZW1zIEZJUiBQb3J0IFR5cGUtRE8KMDA6MGIuMCBDYXJkQnVzIGJy
aWRnZTogVG9zaGliYSBBbWVyaWNhIEluZm8gU3lzdGVtcyBUb1BJQzk1IFBD
SSB0byBDYXJkYnVzIEJyaWRnZSB3aXRoIFpWIFN1cHBvcnQgKHJldiAyMCkK
MDA6MGIuMSBDYXJkQnVzIGJyaWRnZTogVG9zaGliYSBBbWVyaWNhIEluZm8g
U3lzdGVtcyBUb1BJQzk1IFBDSSB0byBDYXJkYnVzIEJyaWRnZSB3aXRoIFpW
IFN1cHBvcnQgKHJldiAyMCkKMDA6MGMuMCBNdWx0aW1lZGlhIGF1ZGlvIGNv
bnRyb2xsZXI6IFlhbWFoYSBDb3Jwb3JhdGlvbiBZTUYtNzQ0QiBbRFMtMVMg
QXVkaW8gQ29udHJvbGxlcl0gKHJldiAwMikKMDE6MDAuMCBWR0EgY29tcGF0
aWJsZSBjb250cm9sbGVyOiBTMyBJbmMuIDg2QzI3MC0yOTQgU2F2YWdlL01Y
LS9JWCAocmV2IDExKQoK

--0-1024766732-982898121=:92642--
