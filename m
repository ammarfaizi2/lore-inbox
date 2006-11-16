Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161948AbWKPHH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161948AbWKPHH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 02:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161958AbWKPHH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 02:07:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:27370 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161950AbWKPHHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 02:07:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jucx0M9jzGlGzTpZGbEgaGT6OmOeFkhvozp0+HPz08z10+q0mtYtzuAOM/gBvJV4R190V5LMn4Z/S5PLjhOsuUiyDeENXL+6WsR759tRvKNA7Cc+UZOjLN/R+LRpPA2vhfFj8GY/uCs2+KTcTML637wrCEorT7cOxKJAPyXP+ik=
Message-ID: <9b33a9230611152307x6580a290n652ee50d9a5bda0c@mail.gmail.com>
Date: Thu, 16 Nov 2006 12:37:24 +0530
From: "sudhnesh adapawar" <sudhnesh@gmail.com>
To: kernelnewbies@nl.linux.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: How does the ski simulator resolves the dependency on shared libraries?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
          How does the ski simulator resolves the dependency on shared
libraries?
              For e.g: I tried 'ls' command on xski but i failed to run it :
[root@basemant /]# xski ls vmlinux simscsi=/var/ski-disks/sd
ls - No such file or directory
ls - No such file or directory
xski: Could not open ls for reading
[root@basemant /]# which ls
alias ls='ls --color=tty'
       /bin/ls
[root@basemant /]# xski /bin/ls vmlinux simscsi=/var/ski-disks/sd
/bin/ls - wrong architecture (3)
xski: Could not open /bin/ls for reading
[root@basemant /]#

Please kindly reply !

- Sudhnesh
