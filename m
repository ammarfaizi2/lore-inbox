Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUBWSSt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUBWSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:18:49 -0500
Received: from palrel12.hp.com ([156.153.255.237]:8856 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261988AbUBWSSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:18:38 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16442.17401.767305.656013@napali.hpl.hp.com>
Date: Mon, 23 Feb 2004 10:18:33 -0800
To: markw@osdl.org
Cc: pgsql-hackers@postgresql.org, linux-kernel@vger.kernel.org,
       linux-lvm@redhat.com, osdldbt-general@lists.sourceforge.net
Subject: dbt-2 tests & profiling on ia64
In-Reply-To: <200402231742.i1NHgcE17332@mail.osdl.org>
References: <200402231742.i1NHgcE17332@mail.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

>>>>> On Mon, 23 Feb 2004 09:42:34 -0800 (PST), markw@osdl.org said:

  Mark> http://developer.osdl.org/markw/ia64/dbt2/
  Mark> I have a summary of intial results from our DBT-2 workload with
  Mark> PostgreSQL 7.4.1 on a 4-way Itanium2 system with 16GB of memory and 56
  Mark> drives using LVM2 and linux-2.6.3.  There's readprofile
  Mark> and oprofile data, but oprofile is seg faulting when it's trying to
  Mark> generate the annotated assembly source.

You could try q-tools, see the announcement here:

 http://marc.theaimsgroup.com/?l=linux-ia64&m=107075994721581

Besides the flat profile, it will also give you call-counts.  (It
would be nice if this feature could be added to oprofile some day.)

	--david
