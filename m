Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWA3KMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWA3KMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWA3KMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:12:41 -0500
Received: from thsmsgxrt12p.thalesgroup.com ([192.54.144.135]:13495 "EHLO
	thsmsgxrt12p.thalesgroup.com") by vger.kernel.org with ESMTP
	id S932199AbWA3KMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:12:40 -0500
Message-ID: <43DDE697.5000007@fr.thalesgroup.com>
Date: Mon, 30 Jan 2006 11:12:39 +0100
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040924
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Can on-demand loading of user-space executables be disabled ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As far as I understand what happens when I start a Linux program, the executable 
file is mmaped into memory and the execution of the code itself prompts Linux to 
load the required pages of the program.

I expect that this could cause unwanted delays during program execution when a 
function that has never been used (nor loaded into memory) is called. This delay 
could be bigger than 10ms while the 2.6 kernel is usually quite predictable 
thanks to Ingo Molnar and others' work.

Is Linux really using on-demand loading ?
Is it very different from what I described in the first paragraph ?
Can on-demand loading be disabled ? (This would seem convenient for my 
applications since I generally start a program that is meant to run as 
predictably as possible for months.)

    thanks for your help,


   P.O. Gaillard

