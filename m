Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbUDFXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUDFXqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:46:16 -0400
Received: from [207.175.35.50] ([207.175.35.50]:17573 "EHLO
	ersatz.eternal-systems.com") by vger.kernel.org with ESMTP
	id S264074AbUDFXqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:46:12 -0400
Message-ID: <40734143.605@eternal-systems.com>
Date: Tue, 06 Apr 2004 16:46:11 -0700
From: Shvetima Gulati <sgulati@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4 kernel: sigsuspend response to simultaneously received signals
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have a question regarding the behavior of sigsuspend() sys call when 
it receives more than one signals from its signal set simultaneously.

It is known that sigsuspend returns only after the signal catching 
function returns. So if sigsuspend receives more than one signals at the 
same time, would it return after "both" handlers return or after the 
first handler returns ?

Any help on this would be more than appreciated,
Thanks,
Shvetima.

-- 
--------------------
Shvetima Gulati
sgulati@eternal-systems.com
Tel: +1 (805) 696 9051 x252; Fax: +1 (805) 696 9083
Eternal Systems, Inc.
5290 Overpass Road, Building D, Santa Barbara, CA 93111
www.eternal-systems.com


