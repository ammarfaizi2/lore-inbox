Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTAAKpp>; Wed, 1 Jan 2003 05:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbTAAKpp>; Wed, 1 Jan 2003 05:45:45 -0500
Received: from [203.124.139.208] ([203.124.139.208]:56393 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id <S267218AbTAAKpo>;
	Wed, 1 Jan 2003 05:45:44 -0500
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: SCSI Group Reservation
Date: Wed, 1 Jan 2003 16:39:05 +0530
Message-ID: <000201c2b186$33a72040$e9bba5cc@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
I am writing a code in a driver for issuing persistent group reservation to
a SCSI disk.
For this I am using the functions scsi_allocate_request to create the
request packet and then calling scsi_wait_req (with command as
PERSISTENT_RESERVE_OUT and service action as Register) to transport the
command to the SCSI disk.
The problem I am facing is I am not able to send the parameter list
(consisting of Reservation key,Service action reservation key etc).with the
command.
The error message which I get is "Invalid field in parameter list" . I guess
this error came because the parameter list
was not supplied .

Can anybody suggest how to send the command and the parameter list together
i.e. whether the command parameter of scsi_wait_req will have both the
command and parameter list together ?

Thanks and Regards
Chandrasekhar

