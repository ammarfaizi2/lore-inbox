Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSIIRy1>; Mon, 9 Sep 2002 13:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSIIRy0>; Mon, 9 Sep 2002 13:54:26 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:12481 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318249AbSIIRyZ>; Mon, 9 Sep 2002 13:54:25 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
To: James.Bottomley@steeleye.com, patmans@us.ibm.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF7A4E6D15.E02468DA-ONC1256C2F.00615DDD@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Mon, 9 Sep 2002 19:58:18 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 09/09/2002 19:58:21
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>Answer me this question:
>- In the forseeable future does multi-path have uses other than SCSI?

The S/390 DASD driver could conceivably make use of generic block layer
(or higher-up) multi-path support.

(We have multi-path support on a lower level, the channel subsystem,
but this helps only with reliability / failover.  Using multi-path
support on a higher level for performance reasons would be helpful
in certain scenarios.)


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

