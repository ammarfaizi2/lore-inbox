Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUHINAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUHINAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUHINAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:00:52 -0400
Received: from main.gmane.org ([80.91.224.249]:17808 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264633AbUHINAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:00:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Mon, 09 Aug 2004 15:00:44 +0200
Message-ID: <yw1x8yco4gar.fsf@kth.se>
References: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:U+WnoodAU5BAGX6jAdvCw1xBLkg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

>>From: Eric Lammerts <eric@lammerts.org>
>
>>On Fri, 6 Aug 2004, Joerg Schilling wrote:
>>> The CAM interface (which is from the SCSI standards group)
>>> usually is implemeted in a way that applications open /dev/cam and
>>> later supply bus, target and lun in order to get connected
>>> to any device on the system that talks SCSI.
>>>
>>> Let me repeat: If you believe that this is a bad idea, give very
>>> good reasons.
>
>>With this interface, how do you grant non-root users access to a CD
>>writer, but prevent them from directly accessing a SCSI harddisk?
>
> On Linux, it is impossible to run cdrecord without root privilleges.

I do it all the time, but then again I also use dev=/dev/hdc which is
also supposedly impossible.

> Make cdrecord suid root, it has been audited....

By whom?  The author?

-- 
Måns Rullgård
mru@kth.se

