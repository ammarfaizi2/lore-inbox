Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161165AbWASLPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWASLPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWASLPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:15:38 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:61330
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1161165AbWASLPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:15:38 -0500
Message-Id: <43CF82EE.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 19 Jan 2006 12:15:42 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: problem building in separate directory
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

beyond the problem reported in http://marc.theaimsgroup.com/?l=linux-kernel&m=113751198318080&w=2, I see another
problem: There now is a .kernelrelease file getting generated in the source tree, making it impossible to build from a
read-only one. Thus I don't think the patch suggested there is correct. Instead, arrangements must be made for the make
to happen in the output tree instead. I didn't have time to come up with a patch for this, yet.

Jan
