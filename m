Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316192AbSFZEuY>; Wed, 26 Jun 2002 00:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSFZEuX>; Wed, 26 Jun 2002 00:50:23 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:8882 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S316192AbSFZEuX>;
	Wed, 26 Jun 2002 00:50:23 -0400
Subject: >8 luns on 2.4.19-pre10-aa4
From: Austin Gonyou <austin@digitalroadkill.net>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1025064208.20341.10.camel@UberGeek>
References: <1025052385.19462.5.camel@UberGeek>
	 <1025056235.19779.4.camel@UberGeek> <20020625194806.C26789@pegasys.ws>
	 <1025060739.20340.6.camel@UberGeek>  <20020625204747.D26789@pegasys.ws>
	  <1025064208.20341.10.camel@UberGeek>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 25 Jun 2002 23:50:19 -0500
Message-Id: <1025067019.20316.19.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone tell me what I'm supposed to do to get a compiled in scsi
subsystem to recognize > 8 luns with 2.4.19-pre10-aa4?

I'm going to go to sleep for now, but if anyone can reply with some info
regarding this, I'd greatly appreciate it. I've got a TB size DB to
create tomorrow and I need all my luns. In the -aa kernel I was going to
go into drivers/scsi/hosts.c and modify max_lun = 8 to 16, recompile and
see what that does. If anyone could tell me I'm wrong or what I'd
appreciate that too. Ultimately, I'd like to know if the -aa series even
looks at max_scsi_luns=xxx at boot time at all when CONFIG_SCSI=y. 

Thanks much. 

-- 
Austin Gonyou <austin@digitalroadkill.net>
