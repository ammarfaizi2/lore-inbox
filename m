Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRABV7w>; Tue, 2 Jan 2001 16:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRABV7m>; Tue, 2 Jan 2001 16:59:42 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:23800 "EHLO ylenurme.ee")
	by vger.kernel.org with ESMTP id <S129692AbRABV7Y>;
	Tue, 2 Jan 2001 16:59:24 -0500
Date: Tue, 2 Jan 2001 23:28:45 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: prerelease total nonmodular compile, compiler warnings, linking
 errors
In-Reply-To: <20010102213045.A2103@storm.local>
Message-ID: <Pine.LNX.4.30.0101022324191.8096-200000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="34210307-160492660-978470925=:8096"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--34210307-160492660-978470925=:8096
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Tue, 2 Jan 2001, Andreas Bombe wrote:
> You're then using the ieee1394.o module object which doesn't include the
> hardware and highlevel drivers.  I've sent a patch to Linus already and
> cc'd the mailing list also.


!!! there were heaps of other (not related to ieee1394 stuff )
linking errors.
hack was for to see other errors

I hope I did not confuse anybody, and those ohter linking errors are
attached again with this letter.

I'd like to see if by grub can load a nonmodular kernel with everything
compiled in (should be about 20MB ? ). Not that it would of any value
other than being nice to see.

elmer.



--34210307-160492660-978470925=:8096
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="err.link"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0101022328450.8096@yle-server.ylenurme.sise>
Content-Description: 
Content-Disposition: attachment; filename="err.link"

ZHJpdmVycy9zb3VuZC9zb3VuZGRyaXZlcnMubzogSW4gZnVuY3Rpb24gYGNs
ZWFudXBfbW9kdWxlJzoNCmRyaXZlcnMvc291bmQvc291bmRkcml2ZXJzLm8o
LnRleHQuZXhpdCsweGYzMCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGNs
ZWFudXBfbW9kdWxlJw0KZHJpdmVycy9pc2RuL2lzZG4uYSgudGV4dCsweDE3
NmQ0KTogZmlyc3QgZGVmaW5lZCBoZXJlDQpsZDogV2FybmluZzogc2l6ZSBv
ZiBzeW1ib2wgYGNsZWFudXBfbW9kdWxlJyBjaGFuZ2VkIGZyb20gMTA1IHRv
IDQ1IGluIGRyaXZlcnMvc291bmQvc291bmRkcml2ZXJzLm8NCmRyaXZlcnMv
c291bmQvc291bmRkcml2ZXJzLm86IEluIGZ1bmN0aW9uIGBpbml0X21vZHVs
ZSc6DQpkcml2ZXJzL3NvdW5kL3NvdW5kZHJpdmVycy5vKC50ZXh0LmluaXQr
MHhhZGUwKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaW5pdF9tb2R1bGUn
DQpkcml2ZXJzL2lzZG4vaXNkbi5hKC50ZXh0KzB4MTc2NzApOiBmaXJzdCBk
ZWZpbmVkIGhlcmUNCmxkOiBXYXJuaW5nOiBzaXplIG9mIHN5bWJvbCBgaW5p
dF9tb2R1bGUnIGNoYW5nZWQgZnJvbSA5NyB0byAyNSBpbiBkcml2ZXJzL3Nv
dW5kL3NvdW5kZHJpdmVycy5vDQpkcml2ZXJzL25ldC9uZXQubzogSW4gZnVu
Y3Rpb24gYG5ldHdvcmtfbGRpc2NfaW5pdCc6DQpkcml2ZXJzL25ldC9uZXQu
bygudGV4dC5pbml0KzB4NTMyZik6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YG1raXNzX2luaXRfY3RybF9kZXYnDQpkcml2ZXJzL25ldC9uZXQubyguZGF0
YS5pbml0KzB4NTI4OTApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB5YW1f
aW5pdCcNCmRyaXZlcnMvbmV0L3Rva2VucmluZy90ci5hKHNtY3RyLm8pOiBJ
biBmdW5jdGlvbiBgc21jdHJfcmVzZXRfYWRhcHRlcic6DQpzbWN0ci5vKC50
ZXh0KzB4MzkyYSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9fYmFkX3Vk
ZWxheScNCnNtY3RyLm8oLnRleHQrMHgzOTM4KTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgX19iYWRfdWRlbGF5Jw0KZHJpdmVycy9pZWVlMTM5NC9pZWVl
MTM5NC5vOiBJbiBmdW5jdGlvbiBgcmVnaXN0ZXJfYnVpbHRpbl9oaWdobGV2
ZWxzJzoNCmRyaXZlcnMvaWVlZTEzOTQvaWVlZTEzOTQubygudGV4dCsweDI3
YjkpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpbml0X3JhdzEzOTQnDQpk
cml2ZXJzL2llZWUxMzk0L2llZWUxMzk0Lm86IEluIGZ1bmN0aW9uIGByZWdp
c3Rlcl9idWlsdGluX2xvd2xldmVscyc6DQpkcml2ZXJzL2llZWUxMzk0L2ll
ZWUxMzk0Lm8oLnRleHQuaW5pdCsweDI0KTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgZ2V0X2x5bnhfdGVtcGxhdGUnDQpkcml2ZXJzL2llZWUxMzk0L2ll
ZWUxMzk0Lm8oLnRleHQuaW5pdCsweDUxKTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgZ2V0X29oY2lfdGVtcGxhdGUnDQpkcml2ZXJzL3ZpZGVvL3ZpZGVv
Lm86IEluIGZ1bmN0aW9uIGBhdHlfc2V0X3BsbDE4ODE4JzoNCmRyaXZlcnMv
dmlkZW8vdmlkZW8ubygudGV4dCsweGMxMjEpOiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGBfX2JhZF91ZGVsYXknDQpkcml2ZXJzL3ZpZGVvL3ZpZGVvLm86
IEluIGZ1bmN0aW9uIGBpbml0X3ZnYWNoaXAnOg0KZHJpdmVycy92aWRlby92
aWRlby5vKC50ZXh0LmluaXQrMHg0MWFkKTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgX19iYWRfdWRlbGF5Jw0KZHJpdmVycy9uZXQvaXJkYS9pcmRhLm86
IEluIGZ1bmN0aW9uIGB0b3Nob2JvZV9nb3Rvc2xlZXAnOg0KZHJpdmVycy9u
ZXQvaXJkYS9pcmRhLm8oLnRleHQrMHg2YjgxKTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgX19iYWRfdWRlbGF5Jw0KbWFrZTogKioqIFt2bWxpbnV4XSBF
cnJvciAxDQo=
--34210307-160492660-978470925=:8096--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
