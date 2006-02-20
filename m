Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWBTWTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWBTWTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWBTWTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:19:17 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:18518 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932285AbWBTWTR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:19:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SDuVzCPBMIXYLwS4ThXeZ4E3dsh9Fl4lLwq0zIVcM3bWkzXsI/1EIiweYiNQ6tcP/ajSIS5CgneRjwD7Ag394xRYGjHjPQDgWiPywSsc0HRiEa1GI4wGd8cWwGrXaUdktEDpSYZNXesJ7kj5wWGuVh6kGV5+4qfDHlQ3CtxWmo8=
Message-ID: <3faf05680602201419v3a6172a1j80e4210dde4c54cf@mail.gmail.com>
Date: Tue, 21 Feb 2006 03:49:13 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Process states inside the linux kernel. [Especially about the STATE D]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

 I have been debugging a program which takes huge memory around 12Gb
(On a 64-bit machine). I was trying to monitor the VmSize and RSS
sizes using top command for this process. I frequently see that the
process STATUS changes its state from 'D' to 'R' most of the time its
in the state 'D'.

 I looked at the manual it says D  uninterruptable sleep state (I have
googled on this but could'nt find much information about this stage).
As far as my text book knowledge, the process is either 1). Running 
'R'  2.) Ready 'Re' 3.) Wait (for I/O) W .

 So what is 'uninterruptable sleep state' D ? when does the process is
put in this state?

 Can someone releate me the states cycle of the process in linux kernel.

 Really appreciate your time and effort.

 Thank you,
 Vamsi.
