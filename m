Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbQLRP4h>; Mon, 18 Dec 2000 10:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbQLRP4W>; Mon, 18 Dec 2000 10:56:22 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:18829 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131909AbQLRP4J>; Mon, 18 Dec 2000 10:56:09 -0500
From: Christoph Rohland <cr@sap.com>
To: Rolf Fokkens <FokkensR@vertis.nl>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: problem with shmat () and > 1GB memory in kernel 2.2.17
In-Reply-To: <938F7F15145BD311AECE00508B7152DB034C3A27@vts007.vertis.nl>
Organisation: SAP LinuxLab
Date: 18 Dec 2000 16:25:05 +0100
In-Reply-To: Rolf Fokkens's message of "Wed, 8 Nov 2000 22:38:47 +0100"
Message-ID: <qwwn1dtda5q.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rolf,

On Wed, 8 Nov 2000, Rolf Fokkens wrote:
>> Recently we installed extra memory in our Oracle-on-Linux database
>> server, it now has 1.25 GB. I installed a 2.2.17 kernel with the
>> 2GB option enabled. I rebooted the machine (a Compaq Proliant 5500
>> dual PII 450MHz) and noticed that one of the databases wasn't able
>> to start. After installing a 2.2.17 kernel without the 2GB option
>> averything worked fine.

You should not use the 2GB option. Use the bigmem patch and you will
have 3GB userspace with 4GB main memory instead of 2GB user space with
2GB memory.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
