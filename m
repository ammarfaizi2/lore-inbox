Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWG1OOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWG1OOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWG1OOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:14:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:1087 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161173AbWG1OOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:14:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sMnQcDPY8b2rR15LnHc6Fzh3WQsYc2v0DaiU+YdZtE+dLeE7E3Z3Gs8k/xG9N0s5gRvmwGvDCrCV3k9/a3lBeQHsgUEOO+F+41xWFdjtpTn8Q8f/sNN8/P5UchTbyP5RoQ/i14z/+pRD3v0LqGURDpzmNFRBQr5DagILArgzfsM=
Message-ID: <41840b750607280713x2f779ba1nbbb59811904b61b6@mail.gmail.com>
Date: Fri, 28 Jul 2006 17:13:57 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: Generic battery interface
Cc: "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       vojtech@suse.cz, "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Brown, Len <len.brown@intel.com> wrote:
> good for shell scripts, not clear it is better for C programs
> that have to open a bunch of files by name.

> Wonderful, but isn't the key here how simple it is for HAL
> or X to understand and use the kernel API rather than the
> developers of the kernel driver that implements the API?

For a C program it's just open()+fscanf()+close(). You can easily wrap
it up in a 10-line function, and that's probably what HAL and friends
are already doing.

Anyway, I was just pointing out a practical advantage. The decision
about sysfs's textual interface has already been taken, for better or
worse, and I don't think it's good to invent a totally new interface
unless there's a strong technical reason why the sysfs model is
inappropriate for this task.

  Shem
