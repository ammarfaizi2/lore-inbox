Return-Path: <linux-kernel-owner+w=401wt.eu-S1753658AbWLRJvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbWLRJvK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbWLRJvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:51:09 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:11665 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbWLRJvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:51:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=flOZKq+72dAkoLSmMPeXdMeQKy++G67jayrk52QqWWdneGZ1V+28FxSI3K2EZotEMUZZ7StNMrCuFPqdmyFgoIyQ7Ac362EfyB9EYsliHc4u2jmR56XoDiU0iQSKgj0sMD0o79AtOYrP3Z80zvP3IQUY2ZMzQWHqdb+e0NeVfeg=
Message-ID: <45866485.4020308@gmail.com>
Date: Mon, 18 Dec 2006 04:51:01 -0500
From: t u <towsonu2003@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bcm43xx not properly working with 2.6.19.1
X-Enigmail-Version: 0.94.1.1
OpenPGP: id=6C096046;
	url=hkp://pgp.mit.edu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I filed this to the bugzilla, but all the documentation I read about the
kernel recommends posting to the mailing lists so here I go:

I'm using Ubuntu 6.06 and after booting with the 2.6.19.1 kernel from
kernel.org, the wireless card that uses bcm43xx driver does not work
properly. It fails with
sudo iwlist eth1 scan
 -> eth1: no scan results (even though there are many many ap's around)

The weird thing, after booting to Ubuntu's kernel, the card didn't work
either. I had to reboot to Windows, activate card and connect to an AP,
and then reboot back to Ubuntu's kernel to make it work properly.

I will probably not be able to test patches, as the bug disables the
card in a weird way (it scared the hell out of me).

I tried to provide all the information I could here:
http://bugzilla.kernel.org/show_bug.cgi?id=7682

Please let me know if I can provide more input,

Thanks,
Sincerely.

PS. Please CC me on your replies, thanks :)
