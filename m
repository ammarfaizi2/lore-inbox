Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTDPOCz (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTDPOCz 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:02:55 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:12416 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S264377AbTDPOCy 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:02:54 -0400
Message-ID: <20030416141438.29271.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Subodh S" <subodh_s_1975@mail.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Apr 2003 09:14:38 -0500
Subject: About tq_disk
X-Originating-Ip: 133.145.164.4
X-Originating-Server: ws1-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wanted to know if the following conclusions are 
right:
generic_plug_device function queue's a task (with 
the generic_unplug_device routine to be executed) in 
the tq_disk queue. 

The __generic_unplug_device function(called from 
generic_unplug_device) calls the request function 
when the task is scheduled (crossed some limit of
buffers) or when free requests are not available.

Besides the above there is no other place where 
unplugging i.e. running of tasks in the task queue 
tq_disk is done.

-subodh


-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

