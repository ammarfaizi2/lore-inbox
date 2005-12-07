Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVLGUje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVLGUje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVLGUje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:39:34 -0500
Received: from web34103.mail.mud.yahoo.com ([66.163.178.101]:47697 "HELO
	web34103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964848AbVLGUjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:39:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bHv2/XOwdwaJdvU0RrJ5likhVHKdCNqbuFqqu4Pi2HaR6FLehu0YC86eBe9gEuDkW+wc0oyP5WqRIdwPXVrRsngLwjUEanmQTO+N+0DGHQ5a+2SvjF2I3MQMESf9wrWGJdktwtAL4kPftncNKKPIRpri373jI5JxsbghkR+LBkQ=  ;
Message-ID: <20051207203932.25422.qmail@web34103.mail.mud.yahoo.com>
Date: Wed, 7 Dec 2005 12:39:32 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: An nfs question ftruncate vs. pwrite
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a file that is opened with normal flags (O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE) is on NFS, and
it is exteded via ftruncate, the new expty pages get read back from the server before the system
call returns:
  (from strace -T):
ftruncate64(3, 41943040)                = 0 <0.063866>


-Kenny



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

