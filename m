Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWFAEEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWFAEEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 00:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWFAEEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 00:04:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:50140 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751710AbWFAEEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 00:04:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aOO8GeaSb009F24Gs5QhEudy3z0WeTMRJkiFNHlll4HWAtwixCENzdr84o3b6QQI3PJ/FYV0ZJ//txx2CdfGDfOVpGXtHTQi21uy0sY8O8QoYI6CPPjwKyWtqq9rSbf9shq2JyB89r+HErxKK1Q6uLec0uOyvaBFfQUGjKXlDXE=
Message-ID: <4ae3c140605312104m441ca006j784a93354456faf8@mail.gmail.com>
Date: Thu, 1 Jun 2006 00:04:11 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Why must NFS access metadata in synchronous mode?
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Until kernel 2.6.16, I think NFS still access metadata synchronously,
which may impact performance significantly. Several years ago, paper
"metadata update performance in file systems" already suggested using
asynchronous mode in metadata access.

I am curious why NFS does not adopt this suggestion? Can someone explain this?

Thanks!

Xin
