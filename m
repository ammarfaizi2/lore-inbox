Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVAZQEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVAZQEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVAZQEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:04:52 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:33155 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262338AbVAZQEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:04:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=kTvoim3ddjlmQml1m+ztgVCDQDrocU044ck0BvKHHnkZ4HHVCHX818MBRyosNEgIqBalI8lMWHhZmqS0A7igrxOeoPlv56vkZtNDV+itWzo9ztyRxyTSPaMAs0mCUT27olUb+M2yMEHVL1DzZIBLar56PdIfQ6mL8sPpLoYKxG8=
Message-ID: <41F7BF8D.70205@gmail.com>
Date: Wed, 26 Jan 2005 17:04:29 +0100
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
Subject: [PATCH 0/3] TIGLUSB Cleanups
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The tiglusb-driver was removed in 2.6.11-rc1.

Since then, references to it in other files have been kept, namely the 
following files:

    Documentation/usb/silverlink.txt,
    Documentation/kernel-parameters.txt
    MAINTAINERS

This series of patches removes the silverlink.txt-documentation, and 
tiglusb-references in MAINTAINERS and kernel-parameters.txt.

The patches are diffed against 2.6.11-rc2-bk4.

Thanks,
Mikkel Krautz

