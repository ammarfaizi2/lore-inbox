Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUBZJMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 04:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbUBZJMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 04:12:40 -0500
Received: from snota.svorka.net ([194.19.72.11]:31137 "HELO snota.svorka.net")
	by vger.kernel.org with SMTP id S262746AbUBZJMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 04:12:38 -0500
Message-ID: <403DB882.9000401@svorka.no>
Date: Thu, 26 Feb 2004 10:12:34 +0100
From: Jo Christian Buvarp <jcb@svorka.no>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ibm Serveraid Problem with 2.4.25
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just upgraded my server with the 2.4.25 kernel and I noticed an error :/
The server is an IBM 345 with a Serveraid 5I controller, when doing an
dmesg i get this error:

attempt to access beyond end of device
08:05: rw=0, want=528036, limit=528034
attempt to access beyond end of device
08:09: rw=0, want=65208120, limit=65208118

This error only shows up in 2.4.25, when rebooting to 2.4.24 everything
looks fine :)
I tried upgrading the serveraid bios to the newest version (6.11.07),
but i still got the error.

So is this an bug in the kernel? Or do I have a problem on my server ?
Is it safe to run 2.4.25 with this error ? Or should i go back to 2.4.24

-- 
--------------------------------------------------------------
Med vennlig hilsen/Yours sincerely
Jo Christian Buvarp
Teknisk Leder
Svorka Aksess AS

Notice:
This e-mail may contain confidential and privileged material for the 
sole use of the intended recipient. Any review or distribution by others 
is strictly prohibited. If this e-mail is received by others than the 
intended recipient, please contact the sender and delete all copies.



