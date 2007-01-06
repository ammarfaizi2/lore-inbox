Return-Path: <linux-kernel-owner+w=401wt.eu-S1751170AbXAFECL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXAFECL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXAFECL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:02:11 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:36147 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751170AbXAFECJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:02:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=MjYwg9oOGtopkMDBQnnmBuIqQFRoQe3dY4eSjdE0qUORpGhSoVWMzqW66mp4DQU2uDzgckmVbUs1JUlotZvzjdmInuqDBaqgGL0DLGasX1/VCejdwfna6ePU9C2dRBRUkRu2zeXXchyp6ehu2VVyVUK32UtQiLKcGgwvemtl7lM=  ;
X-YMail-OSG: dGo5uDsVM1lq6q3j1sa1v16JNbWAQVr7VWvJ0W2hMOmrh6jKtm5MSFrn7pNXJWLMOfSh30sSicJ3YtHXEEc5skZiU01hhTXRnyBQ56bIsRn5Xn39znXs
From: David Brownell <david-b@pacbell.net>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: RTC subsystem and fractions of seconds
Date: Fri, 5 Jan 2007 19:49:00 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701051949.00662.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	Those rtc's actually have a 1/100th of second
> register.  Should the generic rtc interface not support that?

Are you implying a new userspace API, or just an in-kernel update?

Either way, that raises the question of what other features should
be included.  What sub-second precision?  Multiple alarms?  Ways
to manage output clocks?  Sub-HZ periodic alarms?

