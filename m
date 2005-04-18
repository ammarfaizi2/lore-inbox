Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVDRTZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVDRTZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVDRTZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:25:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1161 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262171AbVDRTZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:25:11 -0400
Date: Mon, 18 Apr 2005 15:24:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] procfs privacy: tasks/processes lookup
In-Reply-To: <1113849993.17341.69.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0504181523440.11251@chimarrao.boston.redhat.com>
References: <1113849993.17341.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="=-KPP1Az1xcm3fi98ZHSiL"
Content-ID: <Pine.LNX.4.61.0504181523441.11251@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--=-KPP1Az1xcm3fi98ZHSiL
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.61.0504181523442.11251@chimarrao.boston.redhat.com>

On Mon, 18 Apr 2005, Lorenzo Hernández García-Hierro wrote:

> This patch restricts non-root users to view only their own processes.

This looks like a very bad default to me!

Your patch would force people to run system monitoring
applications as root, because otherwise they cannot get
some of the information they can get now.  Forcing that
these applications run with root rights is a security
risk, not a benefit...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
--=-KPP1Az1xcm3fi98ZHSiL--
