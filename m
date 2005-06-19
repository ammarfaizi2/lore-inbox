Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVFSUcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVFSUcW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFSUcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:32:22 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:19205 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261320AbVFSUcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:32:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=dmFNZWXs01TIgHGoDAv793lAKXi4L2zNIid5p5UryT+0j07lDhQVdR9jbj8j2pptYxDpMNHzk+REGHF9qRDh32T8WTtdLrZbilV6pIdFDzvFVX1jt+C5x60ydkWFbF8Xo234uOZMz125R4xjYQ4FqnRBZ/0JmC70j9D36Wx18yQ=
Message-ID: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
Date: Sun, 19 Jun 2005 22:32:16 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: linux <linux-kernel@vger.kernel.org>
Subject: Script to help users to report a BUG
Cc: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2869_32497240.1119213136473"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2869_32497240.1119213136473
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
what do you think about this simple idea of a script that could help
users to fill better BUG reports ?

The usage is quite simple, put the attached file in
/usr/src/linux/scripts and then:

[root@frodo scripts]# ./report-bug.sh /tmp/BUGREPORT/
cat: /proc/scsi/scsi: No such file or directory

[root@frodo scripts]# ls /tmp/BUGREPORT/
cpuinfo.bug  ioports.bug  modules.bug  software.bug
iomem.bug    lspci.bug    scsi.bug     version.bug

Now you can simply attach all the .bug files to the bugzilla report or
inline them in a email.

The script is rude but it is enough to give you an idea of what I have in m=
ind.

Any comment ?


--=20
Paolo

------=_Part_2869_32497240.1119213136473
Content-Type: application/x-sh; name="report-bug.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="report-bug.sh"

IyEgL2Jpbi9zaAojIFNjcmlwdCB0byBoZWxwIHRoZSB1c2VyIHRvIHN1cHBseSBhIHdlbGwgZG9u
ZSBCVUcgcmVwb3J0CiMKIyBQYW9sbyBDaWFycm9jY2hpIDxwYW9sby5jaWFycm9jY2hpQGdtYWls
LmNvbT4sIDE5dGggSnVuZSAyMDA1LgojIFNldCBkaXJlY3RvcmllcyBmcm9tIGFyZ3VtZW50cywg
b3IgdXNlIGRlZmF1bHRzCm91dGRpcj0kezEtL3RtcH0KY2F0IC9wcm9jL3ZlcnNpb24gPiAkb3V0
ZGlyL3ZlcnNpb24uYnVnCi4vdmVyX2xpbnV4ID4gJG91dGRpci9zb2Z0d2FyZS5idWcKY2F0IC9w
cm9jL2NwdWluZm8gPiAkb3V0ZGlyL2NwdWluZm8uYnVnCmNhdCAvcHJvYy9tb2R1bGVzID4gJG91
dGRpci9tb2R1bGVzLmJ1ZwpjYXQgL3Byb2MvaW9wb3J0cyA+ICRvdXRkaXIvaW9wb3J0cy5idWcK
Y2F0IC9wcm9jL2lvbWVtID4gJG91dGRpci9pb21lbS5idWcKbHNwY2kgLXZ2diA+ICRvdXRkaXIv
bHNwY2kuYnVnCmNhdCAvcHJvYy9zY3NpL3Njc2kgPiAkb3V0ZGlyL3Njc2kuYnVnCgoKCgoK
------=_Part_2869_32497240.1119213136473--
