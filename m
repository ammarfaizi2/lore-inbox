Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267891AbTBRPxu>; Tue, 18 Feb 2003 10:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbTBRPxu>; Tue, 18 Feb 2003 10:53:50 -0500
Received: from smtp.invisible.uk.net ([195.224.32.67]:35487 "EHLO
	invisible.uk.net") by vger.kernel.org with ESMTP id <S267891AbTBRPxu> convert rfc822-to-8bit;
	Tue, 18 Feb 2003 10:53:50 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: /proc/kmsg
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Tue, 18 Feb 2003 16:03:31 -0000
Message-ID: <541025071C7AC24C84E9F82296BB9B952D7D@OPTEX1.optex.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/kmsg
Thread-Index: AcLXZ0gqgvTIum3LSnmB42yem0wVeA==
From: "John Hall" <john.hall@optionexist.co.uk>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to write a small syslogd that has no need of a separate
klogd. So I can use select, I'm attempting to read from /proc/kmsg
instead of using the syslog syscall. However, it seems very unreliable -
I don't see quite a few of the messages I should do. I'm using a
2.4.18-rmk7 kernel.

Is /proc/kmsg inherently unreliable for what I'm doing or am I doing
something wrong?

Cheers,
John
