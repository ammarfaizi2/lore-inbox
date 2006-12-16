Return-Path: <linux-kernel-owner+w=401wt.eu-S1030446AbWLPAOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWLPAOf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWLPAOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 19:14:35 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:7878 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030446AbWLPAOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 19:14:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZeyiZkfXNMKfUCV7xl3L8I7UYVf0xTW6eHze1VvyVaQIQA6/wOKYf8s6WnZ7vq4hg1p09LTZuqvrU1LJmemwLF+DH2kwbFsR8lFbB34cw2IHI7BY8FQpQDq2+IKwUL6TF3JRxcHTfhz2/t0ix5Z+f1Bez2F0lYXXhkavA2nZgRE=
Message-ID: <e6babb600612151614s1814ba9cmb073a92310a5c2c9@mail.gmail.com>
Date: Fri, 15 Dec 2006 17:14:33 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: realtime-preempt and arm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@spanky:~$ uname -r
2.6.19.1-rt15_00

And I'm totally thrilled since this is the first -rt kernel that I've
tried and been able to boot since .16-rt29.  Yay!

root@spanky:~$ zcat /proc/config.gz | egrep "HZ.*=y"
CONFIG_HZ_1000=y

100 revs; min: 5008 max: 5034 avg: 5015
100 revs; min: 5008 max: 5023 avg: 5010
100 revs; min: 5008 max: 5015 avg: 5009
100 revs; min: 5008 max: 5018 avg: 5009
100 revs; min: 5008 max: 5017 avg: 5009
100 revs; min: 5008 max: 5015 avg: 5009
100 revs; min: 5008 max: 5016 avg: 5009
100 revs; min: 5008 max: 5017 avg: 5009
100 revs; min: 5008 max: 5014 avg: 5009
100 revs; min: 5008 max: 5016 avg: 5009
100 revs; min: 5008 max: 5015 avg: 5009
100 revs; min: 5008 max: 5017 avg: 5009
100 revs; min: 5008 max: 5016 avg: 5009
100 revs; min: 5008 max: 5023 avg: 5010
100 revs; min: 5008 max: 5015 avg: 5009
100 revs; min: 5008 max: 5016 avg: 5009
100 revs; min: 5008 max: 5015 avg: 5009
100 revs; min: 5008 max: 5016 avg: 5009
100 revs; min: 5008 max: 5015 avg: 5009
100 revs; min: 5008 max: 5017 avg: 5009
100 revs; min: 5008 max: 5016 avg: 5009
100 revs; min: 5008 max: 5016 avg: 5009
100 revs; min: 5008 max: 5017 avg: 5009
100 revs; min: 5008 max: 5018 avg: 5009
100 revs; min: 5008 max: 5019 avg: 5009
100 revs; min: 5008 max: 5013 avg: 5009

quad Opteron running x86_64 Fedora Core 5.

-- 
Robert Crocombe
rcrocomb@gmail.com
