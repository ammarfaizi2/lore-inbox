Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271200AbTHCPB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 11:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271201AbTHCPB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 11:01:57 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:25492 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S271200AbTHCPBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 11:01:55 -0400
Subject: Re: 2.6.0-test2-mm3 and mysql
From: Shane Shrybman <shrybman@sympatico.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030802190859.3384ee08.akpm@osdl.org>
References: <1059871132.2302.33.camel@mars.goatskin.org>
	 <20030802180410.265dfe40.akpm@osdl.org>
	 <1059875927.2966.32.camel@mars.goatskin.org>
	 <20030802190859.3384ee08.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059922912.2282.15.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Aug 2003 11:01:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 22:08, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:
> >
> > The db corruption hit again on test2-mm2.
> 
> How do you know it is "db corruption"?

I haven't been able to get an exact recipe for producing this but I have
posted a couple of the mysql corruption messages.

I still haven't been able to make it appear in 2.6.0-test1-mm1, but once
when I rebooted from -test1-mm1 to -test2-mm3 the tables had problems
immediately, when they came up clean in -test1-mm1 right before. When I
ran the mysql repair tables command it fixed them up and did not delete
any rows from the corrupted table, (or only very few). The repair
command usually deletes thousands of rows in order to repair the table.

http://zeke.yi.org/linux/mysql.tables.corrupt

I haven't found any info on this error message but maybe someone has
seen it before?

BTW: I am using myisam table type in mysql.

I will let you know if I find the exact way to reproduce this problem.

Regards,

Shane

