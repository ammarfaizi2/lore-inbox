Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTKZQbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 11:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTKZQa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 11:30:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:32648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264253AbTKZQaw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 11:30:52 -0500
Date: Wed, 26 Nov 2003 08:24:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: los@lsd.di.uminho.pt
Cc: sumit_uconn@lycos.com, linux-kernel@vger.kernel.org
Subject: Re: DataBase For Download
Message-Id: <20031126082404.5288b388.rddunlap@osdl.org>
In-Reply-To: <200311261615.17262.los@lsd.di.uminho.pt>
References: <BKAEKFHMDLDDGEAA@mailcity.com>
	<200311261615.17262.los@lsd.di.uminho.pt>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 16:15:17 +0000 Luís Soares <los@lsd.di.uminho.pt> wrote:

| On Wednesday 26 November 2003 15:47, Sumit Narayan wrote:
| > Hi,
| >
| > I am writing a kernel code to test the disk performance and other details
| > under different kind of databases. Could someone help me with details, as
| > to where I can find sample database, which I could use for testing. If I
| > could find benchmarks, it would be great. I am looking for something like,
| > NetBench, but which is for DataBase.
| >
| > Thanks to all...
| >
| 
| If I understood correctly, this might help:
| 	. TPC (www.tpc.org)
| 	. JMOB (jmob.objectweb.org)
| 	. IOZone (http://www.iozone.org)

I would generally call those workloads, not necessarily databases.
It seems that Sumit wants workloads that are specifically for
stressing/testing databases.

OSDL has several database workloads in the STP (Scalable Test
Platform) project at  http://www.osdl.org/stp/
E.g.:
dbt1-1tier  A single tier iteration of the DataBase Transaction One test.
dbt2-1tier  Database test based on TPC-C workload
dbt2-pgsql  Postgres version of DBT test.
dbt3        Database test based on TPC-H
dbt3-pgsql  dbt3 port to PostgreSQL
DOTS        Database test by IBM

Perhaps Sumit could use one or more of these.

--
~Randy
MOTD:  Always include version info.
