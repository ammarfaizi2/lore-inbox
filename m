Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbTDONzi (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbTDONzi 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:55:38 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:63644 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S261452AbTDONzg 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:55:36 -0400
Message-ID: <20030415140713.38173.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Subodh S" <subodh_s_1975@mail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Date: Tue, 15 Apr 2003 09:07:12 -0500
Subject: How to change retry count of lower layer drivers
X-Originating-Ip: 133.145.164.4
X-Originating-Server: ws1-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Whenever the path on which an I/O is in-progress, 
goes down, sd takes a long time to detect it. As per 
my knowledge it would be 60sec * 5(no. of retries) 
plus the time taken by the lower layer driver(hba) 
to detect the failure. Is this correct ?? Is there a 
way available to reduce this "timeout/retry count" 
value without modifying sd.c

-subodh



-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

