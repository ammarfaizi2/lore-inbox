Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268553AbUILJch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268553AbUILJch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUILJch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:32:37 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:12376 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268553AbUILJcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:32:33 -0400
Message-ID: <e7963922040912023274749b14@mail.gmail.com>
Date: Sun, 12 Sep 2004 11:32:33 +0200
From: Stefan Schweizer <sschweizer@gmail.com>
Reply-To: Stefan Schweizer <sschweizer@gmail.com>
To: Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: FYI: my current bigdiff
In-Reply-To: <414415AA.8050503@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25_20649601.1094981553067"
References: <20040909134421.GA12204@elf.ucw.cz>
	 <e796392204091201541320aa31@mail.gmail.com> <414415AA.8050503@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_25_20649601.1094981553067
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 12 Sep 2004 11:23:54 +0200, Stefan Seyfried <seife<at>suse.de> wrote:
> What is "LeaveXBeforeSuspend"?
> 
> just "echo 4 > /proc/acpi/sleep" or "echo disk > /sys/power/state".
> 
>         Stefan
> 

It is an option in the hibernate-script of Bernard Blackham.
You can find the latest Version at http://dagobah.ucc.asn.au/swsusp/script2/

The config is attached.

LeaveXbeforesuspend just does a chvt15 before and chvt 7 after suspend.

------=_Part_25_20649601.1094981553067
Content-Type: application/octet-stream; name="hibernate-disk.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hibernate-disk.conf"

IyBFeGFtcGxlIGhpYmVybmF0ZS5jb25mIGZpbGUuIEFkYXB0IHRvIHlvdXIgb3duIHRhc3Rlcy4K
IyBPcHRpb25zIGFyZSBub3QgY2FzZSBzZW5zaXRpdmUuCiMgCiMgUnVuICJoaWJlcm5hdGUgLWgi
IGZvciBoZWxwIG9uIHRoZSBjb25maWd1cmF0aW9uIGl0ZW1zLgoKIyMjIHN3c3VzcDJfMTUgKGZv
ciBTb2Z0d2FyZSBTdXNwZW5kIDIpCiMgVXNlU3dzdXNwMiB5ZXMKIyBSZWJvb3Qgbm8KIyBFbmFi
bGVFc2NhcGUgeWVzCiMgRGVmYXVsdENvbnNvbGVMZXZlbCAxCiMgSW1hZ2VTaXplTGltaXQgMjAw
CiMjIHVzZWZ1bCBmb3IgaW5pdHJkIHVzYWdlOgojIFN1c3BlbmREZXZpY2UgL2Rldi9oZGEyCiMg
TG9hZFN1c3BlbmRNb2R1bGVzIHN1c3BlbmRfc3dhcCBzdXNwZW5kX2x6ZiBzdXNwZW5kX3RleHQK
IyBVbmxvYWRTdXNwZW5kTW9kdWxlc0FmdGVyUmVzdW1lIHllcwoKIyMjIHN5c2ZzX3Bvd2VyX3N0
YXRlCiMjIFRvIHVzZSAvc3lzL3Bvd2VyL3N0YXRlIHRvIHN1c3BlbmQgeW91ciBtYWNoaW5lICh3
aGljaCBtYXkgb2ZmZXIKIyMgc3VzcGVuZC10by1SQU0sIHN1c3BlbmQtdG8tZGlzaywgc3RhbmRi
eSwgZXRjKSBjb21tZW50IG91dCBhbGwgdGhlIG9wdGlvbnMKIyMgYWJvdmUgZm9yIFNvZnR3YXJl
IFN1c3BlbmQgMiwgYW5kIHVuY29tbWVudCB0aGlzIGxpbmUuIFlvdSBtYXkgcmVwbGFjZSBtZW0K
IyMgd2l0aCBhbnkgb25lIG9mIHRoZSBzdGF0ZXMgZnJvbSAiY2F0IC9zeXMvcG93ZXIvc3RhdGUi
ClVzZVN5c2ZzUG93ZXJTdGF0ZSBkaXNrCgojIyMgZ2xvYmFsIHNldHRpbmdzClZlcmJvc2l0eSAw
CkxvZ0ZpbGUgL3Zhci9sb2cvaGliZXJuYXRlLmxvZwpMb2dWZXJib3NpdHkgMQojIEFsd2F5c0Zv
cmNlIHllcwojIEFsd2F5c0tpbGwgeWVzClN3c3VzcFZUIDE1CiMgRGlzdHJpYnV0aW9uIGRlYmlh
biAobm90IHJlcXVpcmVkIC0gYXV0b2RldGVjdGlvbiBzaG91bGQgd29yaykKCiMjIyBib290c3Bs
YXNoCiMjIElmIHlvdSB1c2UgYm9vdHNwbGFzaCwgYWxzbyBlbmFibGluZyBMZWF2ZVhCZWZvcmVT
dXNwZW5kIGlzIHJlY29tbWVuZGVkIGlmCiMjIHlvdSB1c2UgWCwgb3RoZXJ3aXNlIHlvdSBtYXkg
ZW5kIHVwIHdpdGggYSBnYXJibGVkIFggZGlzcGxheS4KIyBCb290c3BsYXNoIG9uCiMgQm9vdHNw
bGFzaENvbmZpZyAvZXRjL2Jvb3RzcGxhc2gvZGVmYXVsdC9jb25maWcvYm9vdHNwbGFzaC0xMDI0
eDc2OC5jZmcKCiMjIyBjbG9jawpTYXZlQ2xvY2sgeWVzCgojIyMgZGV2aWNlcwojIEluY29tcGF0
aWJsZURldmljZXMgL2Rldi9kc3AgL2Rldi92aWRlbyoKCiMjIyBkaXNrY2FjaGUKIyBEaXNhYmxl
V3JpdGVDYWNoZU9uIC9kZXYvaGRhCgojIyMgZmlsZXN5c3RlbXMKIyBVbm1vdW50IC9uZnNzaGFy
ZSAvd2luZG93cyAvbW50L3NhbWJhc2VydmVyCiMgTW91bnQgL3dpbmRvd3MKCiMjIyBncnViCiMg
Q2hhbmdlR3J1Yk1lbnUgeWVzCiMgR3J1Yk1lbnVGaWxlIC9ib290L2dydWIvbWVudS5sc3QKIyBB
bHRlcm5hdGVHcnViTWVudUZpbGUgL2Jvb3QvZ3J1Yi9tZW51LXN1c3BlbmRlZC5sc3QKCiMjIyBs
aWxvCiMgRW5zdXJlTElMT1Jlc3VtZXMgeWVzCgojIyMgbG9jayAoZ2VuZXJhbGx5IHlvdSBvbmx5
IHdhbnQgb25lIG9mIHRoZSBmb2xsb3dpbmcgb3B0aW9ucykKIyBMb2NrS0RFIHllcwojIExvY2tY
U2NyZWVuU2F2ZXIgeWVzCiMgTG9ja0NvbnNvbGVBcyByb290CgojIyMgbWlzY2xhdW5jaApPblN1
c3BlbmQgMjAgcGdyZXAgbXBsYXllciAmJiBraWxsYWxsIG1wbGF5ZXIKT25TdXNwZW5kIDIyIHJt
bW9kIC1mIG9tbmlib29rCk9uUmVzdW1lIDIwIHBncmVwIGRoY3BjZCAmJiBkaGNwY2QgLW4KCiMj
IyBtb2R1bGVzClVubG9hZE1vZHVsZXMgYnV0dG9uCiMgVW5sb2FkQWxsTW9kdWxlcyB5ZXMKIyBV
bmxvYWRCbGFja2xpc3RlZE1vZHVsZXMgeWVzCkxvYWRNb2R1bGVzIGJ1dHRvbiBvbW5pYm9vawoj
IExvYWRNb2R1bGVzRnJvbUZpbGUgL2V0Yy9tb2R1bGVzCgojIyMgbW9kdWxlcy1nZW50b28KIyBH
ZW50b29Nb2R1bGVzQXV0b2xvYWQgeWVzCgojIyMgbmV0d29yawojIERvd25JbnRlcmZhY2VzIGV0
aDAKIyBVcEludGVyZmFjZXMgYXV0bwoKIyMjIHByb2dyYW1zCiMgSW5jb21wYXRpYmxlUHJvZ3Jh
bXMgeG1tcwoKIyMjIHNlcnZpY2VzCiMgUmVzdGFydFNlcnZpY2VzIHBvc3RmaXgKIyBTdG9wU2Vy
dmljZXMgbXBsYXllcgojIFN0YXJ0U2VydmljZXMgYXVtaXgKCiMjIyB4aGFja3MKTGVhdmVYQmVm
b3JlU3VzcGVuZCB5ZXMKIyBuVmlkaWFIYWNrIHllcwoK
------=_Part_25_20649601.1094981553067--
