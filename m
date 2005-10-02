Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVJBOVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVJBOVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 10:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVJBOVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 10:21:30 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:35499 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751102AbVJBOV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 10:21:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=aqW2YR7KheQk3lcFGbJdX1JP4F0zJJULMVR3YytfS9jNqo0eW5At81k0CODjaxWhmKnR4MbkhxlNkrbxgu1h2e2vP24IZUnVzOPoGuB2T7oIKmVvFTCwdAPhyMi2wW25Td1xiMy8sTQPJf888U/qNlAAEyz/T8Wpqse6dUhf16I=
Message-ID: <433FED06.8070806@gmail.com>
Date: Sun, 02 Oct 2005 22:21:58 +0800
From: Yan Zheng <yzcorp@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, roque@di.fc.ul.pt
Subject: [PATCH] fix ipv6 fragment ID selection at slow path
Content-Type: multipart/mixed;
 boundary="------------040306010602010607090107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040306010602010607090107
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------040306010602010607090107
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

LS0tIGxpbnV4LTIuNi4xMy4yL25ldC9pcHY2L2lwNl9vdXRwdXQuYwkyMDA1LTA5LTE3IDA5
OjAyOjEyLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgvbmV0L2lwdjYvaXA2X291dHB1dC5j
CTIwMDUtMTAtMDIgMjI6MTI6NTQuMDAwMDAwMDAwICswODAwCkBAIC03MDEsNyArNzAxLDcg
QEAKIAkJICovCiAJCWZoLT5uZXh0aGRyID0gbmV4dGhkcjsKIAkJZmgtPnJlc2VydmVkID0g
MDsKLQkJaWYgKGZyYWdfaWQpIHsKKwkJaWYgKCFmcmFnX2lkKSB7CiAJCQlpcHY2X3NlbGVj
dF9pZGVudChza2IsIGZoKTsKIAkJCWZyYWdfaWQgPSBmaC0+aWRlbnRpZmljYXRpb247CiAJ
CX0gZWxzZQo=
--------------040306010602010607090107--
