Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVBLTXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVBLTXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 14:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVBLTXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 14:23:45 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:38288 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261189AbVBLTXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 14:23:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=HxXtcGzHdWxyRh++Qrrkt+DkWntL8YpoLdA8+eRa8KwFZfrV0wMEjVix/xNtyagYPIoLz4PasslsHAkT8toFBN3rrUUVOV2LTnJJchGYRmnQY9q6+GT7q5tG2S7CZsY99L1tXoPJ+NyjtSRK4Mu9dm8EhujP7U7IpGM2qDd6wJM=
Message-ID: <f396da08050212112363a4b5cf@mail.gmail.com>
Date: Sat, 12 Feb 2005 21:23:43 +0200
From: Margus Eha <margus.eha@gmail.com>
Reply-To: Margus Eha <margus.eha@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: bttv: tuner: i2c i/o error: rc == -121 (should be 4)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tv card works but i can't change channel. Something goes wrong in tuner.c
when tvtime program tries to change frequency. In /var/log/messages i can find
tuner: i2c i/o error: rc == -121 (should be 4). 

Las working version i tried was 2.6.11-rc2
Both 2.6.11-rc3-mm1 and Both 2.6.11-rc3-mm2 are not working.

If kernel conf is needed i can send.


Margus
